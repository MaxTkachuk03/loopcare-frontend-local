// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/application/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_details_subscriptions.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_service.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:loopcare_frontend/features/subscription/donain/purchased_product.dart';
import 'package:loopcare_frontend/features/subscription/donain/server_product.dart';
import 'package:loopcare_frontend/features/subscription/donain/subscription_state.dart';
import 'package:loopcare_frontend/features/subscription/donain/valid_status.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_ios.dart';
import 'package:loopcare_frontend/features/subscription/utils/date_utils.dart';

import '../../../injection.dart';

part 'subscription_bloc.freezed.dart';

part 'subscription_event.dart';

part 'subscription_state.dart';

const delayDuration = 60;

@singleton
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  late PurchaseDetailsStreamSubscription purchaseDetailsStreamSubscription;
  final AppSubscriptionService inAppPurchaseService;
  final AuthenticationService _authenticationService;
  final PurchaseService _purchaseService;
  final AuthTokenManager authTokenManager;
  final SocketService _socketService = SocketService.instance;
  bool isValidatePastIOSPurchase = false;
  ProductDetails? buyingProduct;

  SubscriptionBloc(this._authenticationService, this._purchaseService, this.authTokenManager,
      this.inAppPurchaseService)
      : super(const SubscriptionState.initial(SubscriptionStateData())) {
    on<SubscriptionInit>(_onInitSubscription);
    on<SubscriptionDispose>(_onSubscriptionDispose);
    on<SubscriptionLogout>(_onLogout);
    on<GetPlansFromServer>(_onGetPlansFromServer);
    on<BuySubscription>(_onBuySubscription);
    on<NotifyUser>(_notifyUser);
    on<VerifyLastPurchase>(_onVerifyLastPurchase);
    on<RestorePurchased>(_onRestorePurchased);
    on<PurchasedSubscription>(_onPurchasedSubscription);
    on<ErrorVerifyPurchase>(_onErrorVerifyPurchase);
    on<GetActiveSubscription>(_onGetActiveSubscription);
    on<GetAccountSubscription>(_onGetAccountSubscription);
    on<GetSubscriptionPlans>(_onGetSubscriptionPlans);

    purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscription(
      onError: (error) => isValidatePastIOSPurchase
          ? _verifyOldPurchase(null, buyingProduct!)
          : add(SubscriptionEvent.errorVerifyPurchase(error)),
      onRestored: (purchase) async => _restoreTransactionData(purchase),
      onPurchased: (PurchaseDetails purchaseDetails) async => _handlePurchase(purchaseDetails),
    )..init();
  }

  // 1
  FutureOr<void> _onVerifyLastPurchase(
    VerifyLastPurchase event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      const SubscriptionState.initial(SubscriptionStateData()),
    );
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    isValidatePastIOSPurchase = true;
    _getOldPurchase(event.product);
  }

  //2
  void _getOldPurchase(ProductDetails product) async {
    PurchaseDetails? oldPurchaseDetails;
    if (Platform.isAndroid) {
      {
        final InAppPurchaseAndroidPlatformAddition androidAddition = inAppPurchaseService.instance
            .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
        final QueryPurchaseDetailsResponse oldPurchases =
            await androidAddition.queryPastPurchases();
        if (oldPurchases.pastPurchases.isNotEmpty) {
          oldPurchaseDetails = oldPurchases.pastPurchases.last;
        }
        await _verifyOldPurchase(oldPurchaseDetails, product);
      }
    } else {
      isValidatePastIOSPurchase = true;
      buyingProduct = product;
      inAppPurchaseService.instance.restorePurchases();
    }
  }

// 3
  Future<void> _verifyOldPurchase(
      PurchaseDetails? oldPurchaseDetails, ProductDetails product) async {
    isValidatePastIOSPurchase = false;
    late Either<RequestError, ValidStatus> response;
    if (oldPurchaseDetails == null) {
      response = await _apiVerifiedEmpty();
    } else {
      response = await _apiVerified(oldPurchaseDetails);
    }
    response.fold((error) {
      add(SubscriptionEvent.errorVerifyPurchase(error));
    }, (r) async {
      r.valid ?? true
          ? add(SubscriptionEvent.buySubscription(product))
          : add(const SubscriptionEvent.errorVerifyPurchase(RequestError.streamSubscription(
              ServerErrorData(message: LocalizedTexts.subscriptionServiceUnavailable))));
    });
  }

  // 4
  FutureOr<void> _onBuySubscription(
    BuySubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );

    final inAppPurchaseService = getIt<AppSubscriptionService>();

    try {
      final purchased = await inAppPurchaseService.buyItemInStore(event.product);
      if (!purchased) {
        emit(
          SubscriptionState.error(
            state.data.copyWith(
              error: const RequestError.streamSubscription(
                  ServerErrorData(message: LocalizedTexts.subscriptionServiceUnavailable)),
              isLoading: false,
            ),
          ),
        );
      } else {
        emit(
          SubscriptionState.loading(state.data.copyWith(isWaitTimeout: true)),
        );
        add(const SubscriptionEvent.notifyUser());
      }
    } catch (e) {
      emit(
        SubscriptionState.loading(state.data.copyWith(isLoading: false)),
      );
      emit(
        SubscriptionState.purchaseDuplicateSubscription(
          state.data.copyWith(
            error: const RequestError.streamSubscription(
                ServerErrorData(message: LocalizedTexts.purchaseErrorMessage)),
            isLoading: false,
          ),
        ),
      );
    }
  }

  FutureOr<void> _notifyUser(
    NotifyUser event,
    Emitter<SubscriptionState> emit,
  ) async {
    await Future.delayed(
      const Duration(seconds: delayDuration),
      () {
        if (state.data.isWaitTimeout) {
          emit(SubscriptionState.askRestoredSubscription(
              state.data.copyWith(isLoading: false, isWaitTimeout: false)));
        }
      },
    );
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    // todo: resolve using regular event-state flow
    // ignore: invalid_use_of_visible_for_testing_member
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true, isWaitTimeout: false)),
    );
    try {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        await _verifyPurchasedOrRestore(purchaseDetails);
      }
    } catch (_, __) {}
  }

  Future<void> _verifyPurchasedOrRestore(PurchaseDetails purchaseDetails) async {
    final response = await _apiPurchaseOrRestore(purchaseDetails);
    response.fold(
      (error) {
        add(SubscriptionEvent.errorVerifyPurchase(error));
      },
      (r) async {
        final accessTokenUpdated = await authTokenManager.updateAccessToken();
        if (accessTokenUpdated) {
          CustomerIoService.track(
            event: CIOEvents.subscriptionBought,
            attributes: {
              CIOAttributes.identifierOption: purchaseDetails.productID,
              CIOAttributes.subscriptionExpirationDate: r.expiresAt,
            },
          );
          final identifier = _getTransactionId(purchaseDetails) ?? '';
          AnalyticsEventService.appsFlyer().logEvent(
            eventName: AnalyticsEvents.subscriptionBought,
            parameters: {
              AnalyticsParameters.subscriptionContentId: purchaseDetails.purchaseID,
              AnalyticsParameters.subscriptionTransactionId: identifier,
              AnalyticsParameters.subscriptionContentType: purchaseDetails.productID,
              AnalyticsParameters.subscriptionEventTime: r.purchasedAt,
            },
          );
          add(
            SubscriptionEvent.purchasedSubscription(
              r,
              PurchasedProduct(
                purchaseDetails: purchaseDetails,
                memberSince: SubscriptionDateUtils.getTransactionDate(r.purchasedAt),
              ),
            ),
          );
        } else {
          add(const SubscriptionEvent.errorVerifyPurchase(RequestError.streamSubscription(
              ServerErrorData(message: LocalizedTexts.subscriptionServiceUnavailable))));
        }
      },
    );
  }

  Future<Either<RequestError, Subscription>> _apiPurchaseOrRestore(
      PurchaseDetails purchaseDetails) async {
    var isIOS = purchaseDetails is AppStorePurchaseDetails;
    final vendor = isIOS ? 'ios' : 'android';
    final identifier = _getTransactionId(purchaseDetails) ?? '';
    var response = isIOS
        ? await _purchaseService.purchaseIOS(
            VerifyIOSPurchaseData(
                receipt: purchaseDetails.verificationData.serverVerificationData,
                transactionId: identifier),
            vendor)
        : await _purchaseService.purchaseAndroid(
            VerifyAndroidPurchaseData(
                receipt: purchaseDetails.verificationData.serverVerificationData,
                purchaseToken: identifier),
            vendor);
    return response;
  }

  Future<Either<RequestError, ValidStatus>> _apiVerifiedEmpty() async {
    final vendor = Platform.isIOS ? 'ios' : 'android';
    var response = Platform.isIOS
        ? await _purchaseService.verifyPurchaseIOS(null, vendor)
        : await _purchaseService.verifyPurchaseAndroid(null, vendor);
    return response;
  }

  Future<Either<RequestError, ValidStatus>> _apiVerified(PurchaseDetails purchaseDetails) async {
    var isIOS = purchaseDetails is AppStorePurchaseDetails;
    final vendor = isIOS ? 'ios' : 'android';
    final identifier = _getTransactionId(purchaseDetails) ?? '';
    var response = isIOS
        ? await _purchaseService.verifyPurchaseIOS(
            VerifyIOSPurchaseData(
                receipt: purchaseDetails.verificationData.serverVerificationData,
                transactionId: identifier),
            vendor)
        : await _purchaseService.verifyPurchaseAndroid(
            VerifyAndroidPurchaseData(
                receipt: purchaseDetails.verificationData.serverVerificationData,
                purchaseToken: identifier),
            vendor);
    return response;
  }

  void _restoreTransactionData(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.restored) {
      if (isValidatePastIOSPurchase) {
        if (buyingProduct == null) {
          return;
        }
        await _verifyOldPurchase(purchaseDetails, buyingProduct!);
      } else {
        await _verifyPurchasedOrRestore(purchaseDetails);
      }
    }
  }

  String? _getTransactionId(PurchaseDetails purchaseDetails) {
    if (purchaseDetails is AppStorePurchaseDetails) {
      final transactionIdentifier = purchaseDetails.skPaymentTransaction.transactionIdentifier;
      final purchaseID = transactionIdentifier;
      return purchaseID;
    } else if (purchaseDetails is GooglePlayPurchaseDetails) {
      final originalBilling = purchaseDetails.billingClientPurchase;
      return originalBilling.purchaseToken;
    } else {
      return null;
    }
  }

  FutureOr<void> _onPurchasedSubscription(
    PurchasedSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: false)),
    );
    emit(SubscriptionState.purchasedSubscription(state.data.copyWith(
      purchased: event.purchasedProduct,
      subscription: event.subscription,
      isLoading: false,
    )));
  }

  FutureOr<void> _onErrorVerifyPurchase(
    ErrorVerifyPurchase event,
    Emitter<SubscriptionState> emit,
  ) async =>
      emit(SubscriptionState.error(state.data.copyWith(
        error: event.error,
        isLoading: false,
      )));

  FutureOr<void> _onRestorePurchased(
    RestorePurchased event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    isValidatePastIOSPurchase = false;
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    inAppPurchaseService.restorePurchase();
  }

  FutureOr<void> _onGetPlansFromServer(
    GetPlansFromServer event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    final vendor = Platform.isIOS ? 'ios' : 'android';
    var response = await _purchaseService.getProductList(vendor);
    response.fold((error) {
      emit(SubscriptionState.serviceSubscriptionUnavailable(state.data));
    }, (r) {
      List<ServerProduct> serverList = [...r.data];
      serverList.sort((a, b) => a.price!.toInt().compareTo(b.price!.toInt()));
      emit(
        SubscriptionState.loading(state.data.copyWith(isLoading: false, serverPlans: serverList)),
      );
      add(const SubscriptionEvent.getSubscriptionPlans());
    });
  }

  FutureOr<void> _onGetSubscriptionPlans(
    GetSubscriptionPlans event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    Set<String> products = {};
    for (final product in state.data.serverPlans) {
      products.add(product.productId!);
      log.i(
        'PRODUCT: ${product.productId}',
        error: LogTitle.subscription,
      );
    }

    final inAppPurchaseService = getIt<AppSubscriptionService>();
    final plans = await inAppPurchaseService.getSubscriptionPlans(products);
    if (plans.isEmpty) {
      emit(
        SubscriptionState.loading(state.data.copyWith(isLoading: false)),
      );
      emit(SubscriptionState.serviceSubscriptionUnavailable(state.data));
    } else {
      emit(
        SubscriptionState.successInPlans(state.data.copyWith(isLoading: false, plans: plans)),
      );
      add(const SubscriptionEvent.getActiveSubscription());
    }
  }

  FutureOr<void> _onGetAccountSubscription(
    GetAccountSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    final response = await _authenticationService.fetchAccount();
    response.fold(
      (error) => emit(SubscriptionState.error(state.data.copyWith(error: error, isLoading: false))),
      (r) => emit(
        SubscriptionState.gotAccountSubscription(
            state.data.copyWith(isLoading: false, subscription: r.subscription)),
      ),
    );
  }

  FutureOr<void> _onGetActiveSubscription(
    GetActiveSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    final response = await _authenticationService.fetchAccount();
    response.fold(
      (error) {
        emit(SubscriptionState.error(state.data.copyWith(error: error, isLoading: false)));
      },
      (r) {
        final subscription = r.subscription;
        emit(
          SubscriptionState.loading(state.data.copyWith(isLoading: false)),
        );
        switch (subscription.state) {
          case SubscriptionStatus.trialPeriod:
            if (subscription.isActive) {
              emit(SubscriptionState.subscriptionActive(
                  state.data.copyWith(subscription: subscription)));
            } else if (!subscription.isActive &&
                SubscriptionDateUtils.isPassDate(subscription.expiresAt)) {
              emit(SubscriptionState.subscriptionEnded(
                  state.data.copyWith(subscription: subscription)));
            } else {
              emit(SubscriptionState.trial(state.data.copyWith(subscription: subscription)));
            }
            break;
          case SubscriptionStatus.common:
            if (!subscription.isActive &&
                SubscriptionDateUtils.isPassDate(subscription.expiresAt)) {
              emit(SubscriptionState.subscriptionEnded(
                  state.data.copyWith(subscription: subscription)));
            } else if (subscription.isActive) {
              emit(SubscriptionState.subscriptionActive(
                  state.data.copyWith(subscription: subscription)));
            } else {
              emit(SubscriptionState.trialExpired(state.data.copyWith(subscription: subscription)));
            }
            break;
          case SubscriptionStatus.cancelled:
            if (SubscriptionDateUtils.isPassDate(subscription.expiresAt) ||
                !subscription.isActive) {
              // if cancelled by user  and expired time => status: Ended
              emit(SubscriptionState.subscriptionEnded(
                  state.data.copyWith(subscription: subscription)));
            } else if (subscription.isActive) {
              emit(SubscriptionState.subscriptionActive(
                  state.data.copyWith(subscription: subscription)));
            }
            break;
          case SubscriptionStatus.refunded:
            emit(SubscriptionState.subscriptionCancelled(
                state.data.copyWith(subscription: subscription)));
            break;

          case SubscriptionStatus.gracePeriod:
            if (subscription.isActive) {
              emit(SubscriptionState.subscriptionUnRenewed(
                  state.data.copyWith(subscription: subscription)));
            } else {
              emit(SubscriptionState.subscriptionEnded(
                  state.data.copyWith(subscription: subscription)));
            }
            break;
          default:
            emit(SubscriptionState.trial(state.data.copyWith(subscription: subscription)));
        }
      },
    );
  }

  FutureOr<void> _onInitSubscription(
    SubscriptionInit event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionState.initial(SubscriptionStateData()));
  }

  FutureOr<void> _onSubscriptionDispose(
    SubscriptionDispose event,
    Emitter<SubscriptionState> emit,
  ) {
    purchaseDetailsStreamSubscription.close();
    emit(SubscriptionState.success(state.data));
  }

  FutureOr<void> _onLogout(
    SubscriptionLogout event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    purchaseDetailsStreamSubscription.close();
    await _authenticationService.logout();
    await authTokenManager.removeAccessToken();
    await authTokenManager.removeRefreshToken();
    CustomerIoService.logOut();
    _socketService.disconnect();
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: false)),
    );
    emit(SubscriptionState.logout(state.data));
  }
}
