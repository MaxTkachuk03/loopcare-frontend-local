// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/facebook_events_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/infrastructure/services/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_details_subscriptions.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_service.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:loopcare_frontend/features/subscription/domain/purchased_product.dart';
import 'package:loopcare_frontend/features/subscription/domain/server_product.dart';
import 'package:loopcare_frontend/features/subscription/domain/subscription_state.dart';
import 'package:loopcare_frontend/features/subscription/domain/valid_status.dart';
import 'package:loopcare_frontend/features/subscription/domain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/domain/verify_purchase_data_ios.dart';
import 'package:loopcare_frontend/features/subscription/utils/date_utils.dart';

//import for AppStoreProductDetails
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

//import for SKProductWrapper
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:loopcare_frontend/injection.dart';

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
    on<VerifyLastPurchase>(_onVerifyLastPurchase);
    on<RestorePurchased>(_onRestorePurchased);
    on<PurchasedSubscription>(_onPurchasedSubscription);
    on<ErrorPurchase>(_onErrorPurchase);
    on<GetActiveSubscription>(_onGetActiveSubscription);
    on<GetAccountSubscription>(_onGetAccountSubscription);
    on<GetSubscriptionPlans>(_onGetSubscriptionPlans);
    on<CanceledByUser>(_cancelledByUser);

    purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscription(
      onError: (error) => add(SubscriptionEvent.errorPurchase(error)),
      onRestored: (purchase) async => _restoreTransactionData(purchase),
      onPurchased: (PurchaseDetails purchaseDetails) async => _handlePurchase(purchaseDetails),
      onCanceled: () => add(const SubscriptionEvent.canceledByUser()),
      onEmpty: () => isValidatePastIOSPurchase
          ? _verifyOldPurchase(null, buyingProduct!)
          : log.i('No any transactions from  store history'),
    )..init();
  }

  FutureOr<void> _onVerifyLastPurchase(
    VerifyLastPurchase event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionState.initial(SubscriptionStateData()));
    emit(SubscriptionState.loading(state.data.copyWith(isLoading: true)));
    isValidatePastIOSPurchase = true;
    _getOldPurchase(event.product);
  }

  void _getOldPurchase(ProductDetails product) async {
    PurchaseDetails? oldPurchaseDetails;
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          inAppPurchaseService.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final QueryPurchaseDetailsResponse oldPurchases = await androidAddition.queryPastPurchases();
      if (oldPurchases.pastPurchases.isNotEmpty) {
        oldPurchaseDetails = oldPurchases.pastPurchases.last;
      }
      await _verifyOldPurchase(oldPurchaseDetails, product);
    } else {
      isValidatePastIOSPurchase = true;
      buyingProduct = product;
      inAppPurchaseService.instance.restorePurchases();
    }
  }

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
      _pushAnalyticErrorVerifyLastPurchase(product);
      add(SubscriptionEvent.errorPurchase(error));
    }, (r) async {
      if (r.valid ?? true) {
        add(SubscriptionEvent.buySubscription(product));
      } else {
        _pushAnalyticErrorVerifyLastPurchase(product);
        add(
          const SubscriptionEvent.errorPurchase(
            RequestError.streamSubscription(
              ServerErrorData(message: LocalizedTexts.errorSomethingWentWrong),
            ),
          ),
        );
      }
    });
  }

  FutureOr<void> _onBuySubscription(
    BuySubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    try {
      _pushAnalyticStartPurchase(event);
      final purchased = await inAppPurchaseService.buyItemInStore(event.product);
      if (!purchased) {
        emit(
          SubscriptionState.error(
            state.data.copyWith(
              error: const RequestError.streamSubscription(
                ServerErrorData(message: LocalizedTexts.errorPurchaseErrorMessage),
              ),
              isLoading: false,
            ),
          ),
        );
      } else {
        emit(
          SubscriptionState.loading(
            state.data.copyWith(
              product: event.product,
            ),
          ),
        );
      }
    } catch (e) {
      _pushAnalyticDuplicatePurchase(event);
      emit(
        SubscriptionState.purchaseDuplicateSubscription(
          state.data.copyWith(
            error: const RequestError.streamSubscription(
              ServerErrorData(message: LocalizedTexts.errorPurchaseErrorMessage),
            ),
            isLoading: false,
          ),
        ),
      );
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
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
        _pushAnalyticErrorVerifyOnServer(purchaseDetails);
        add(SubscriptionEvent.errorPurchase(error));
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

          final price = state.data.product?.price;
          final currencyCode = state.data.product?.currencyCode;

          FacebookEventsService.logEvent(
            eventName: '${AnalyticsEvents.subscriptionBought}_${price}_$currencyCode',
            parameters: {
              AnalyticsParameters.subscriptionRevenue: state.data.product?.price,
              AnalyticsParameters.subscriptionCurrencyCode: state.data.product?.currencyCode,
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
          add(
            const SubscriptionEvent.errorPurchase(
              RequestError.streamSubscription(
                ServerErrorData(message: LocalizedTexts.errorPurchaseVerificationError),
              ),
            ),
          );
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
  ) async =>
      emit(
        SubscriptionState.purchasedSubscription(
          state.data.copyWith(
            purchased: event.purchasedProduct,
            subscription: event.subscription,
            isLoading: false,
          ),
        ),
      );

  FutureOr<void> _onErrorPurchase(
    ErrorPurchase event,
    Emitter<SubscriptionState> emit,
  ) async =>
      emit(
        SubscriptionState.error(
          state.data.copyWith(
            error: event.error,
            isLoading: false,
          ),
        ),
      );

  FutureOr<void> _onRestorePurchased(
    RestorePurchased event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(SubscriptionState.loading(state.data.copyWith(isLoading: true)));
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
      emit(
        SubscriptionState.error(
          state.data.copyWith(
            error: error,
            isLoading: false,
          ),
        ),
      );
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
    emit(SubscriptionState.loading(state.data.copyWith(isLoading: true)));
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
      emit(SubscriptionState.serviceSubscriptionUnavailable(state.data.copyWith(isLoading: false)));
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
          state.data.copyWith(isLoading: false, subscription: r.subscription),
        ),
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
    emit(SubscriptionState.loading(state.data.copyWith(isLoading: true)));
    purchaseDetailsStreamSubscription.close();
    await _authenticationService.logout();
    await authTokenManager.removeAccessToken();
    await authTokenManager.removeRefreshToken();
    CustomerIoService.logOut();
    _socketService.disconnect();
    emit(SubscriptionState.logout(state.data.copyWith(isLoading: false)));
  }

  FutureOr<void> _cancelledByUser(
    CanceledByUser event,
    Emitter<SubscriptionState> emit,
  ) async {
    CustomerIoService.track(
      event: AnalyticsEvents.subscriptionUserClosePurchaseDialog,
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: AnalyticsEvents.subscriptionUserClosePurchaseDialog,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: false)),
    );
  }

  void _pushAnalyticStartPurchase(BuySubscription event) {
    CustomerIoService.track(
      event: AnalyticsEvents.subscriptionStartPurchase,
      attributes: {
        CIOAttributes.identifierOption: event.product.id,
      },
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: AnalyticsEvents.subscriptionStartPurchase,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.productIdentifier: event.product.id,
      },
    );
  }

  void _pushAnalyticErrorVerifyLastPurchase(ProductDetails product) {
    CustomerIoService.track(
      event: AnalyticsEvents.subscriptionErrorVerifyLastPurchaseOnServer,
      attributes: {
        CIOAttributes.identifierOption: product.id,
      },
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: AnalyticsEvents.subscriptionErrorVerifyLastPurchaseOnServer,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.productIdentifier: product.id,
      },
    );
  }

  void _pushAnalyticDuplicatePurchase(BuySubscription event) {
    CustomerIoService.track(
      event: AnalyticsEvents.subscriptionDuplicatePurchase,
      attributes: {
        CIOAttributes.identifierOption: event.product.id,
      },
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: AnalyticsEvents.subscriptionDuplicatePurchase,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.productIdentifier: event.product.id,
      },
    );
  }

  void _pushAnalyticErrorVerifyOnServer(PurchaseDetails purchaseDetails) {
    CustomerIoService.track(
      event: AnalyticsEvents.subscriptionErrorVerifyOnServer,
      attributes: {
        CIOAttributes.identifierOption: purchaseDetails.productID,
      },
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: AnalyticsEvents.subscriptionErrorVerifyOnServer,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.productIdentifier: purchaseDetails.productID,
      },
    );
  }
}
