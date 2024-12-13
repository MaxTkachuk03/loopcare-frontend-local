// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
//import for SKProductWrapper
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
//import for AppStoreProductDetails
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/domain/extensions/iterable_extentions.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/facebook_events_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/mixpanel_event_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/subscription/domain/purchased_product.dart';
import 'package:loopcare_frontend/features/subscription/domain/server_product.dart';
import 'package:loopcare_frontend/features/subscription/domain/services/purchase_service.dart';
import 'package:loopcare_frontend/features/subscription/domain/subscription_state.dart';
import 'package:loopcare_frontend/features/subscription/domain/valid_status.dart';
import 'package:loopcare_frontend/features/subscription/domain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/domain/verify_purchase_data_ios.dart';
import 'package:loopcare_frontend/features/subscription/infrastructure/purchase_details_subscriptions.dart';
import 'package:loopcare_frontend/features/subscription/infrastructure/subscription_service.dart';
import 'package:loopcare_frontend/features/subscription/utils/date_utils.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

part 'subscription_bloc.freezed.dart';
part 'subscription_event.dart';
part 'subscription_state.dart';

const delayDuration = 60;

@singleton
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  late PurchaseDetailsStreamSubscription _purchaseDetailsStreamSubscription;
  final AppSubscriptionService _inAppPurchaseService;
  final AuthenticationService _authenticationService;
  final PurchaseService _purchaseService;
  final AuthTokenManager _authTokenManager;
  final usageAnalytics = UsageAnalytics();
  bool _checkEligibility = false;

  SubscriptionBloc(this._authenticationService, this._purchaseService,
      this._authTokenManager, this._inAppPurchaseService)
      : super(const SubscriptionState.initial(SubscriptionStateData())) {
    on<SubscriptionInit>(_onInitSubscription);
    on<CheckEligibility>(_onCheckEligibility);
    on<SetEligibility>(_setEligibility);
    on<GetPlansFromServer>(_onGetPlansFromServer);
    on<GetSubscriptionPlans>(_onGetSubscriptionPlans);
    on<ProcessingDataPlans>(_processingDataPlans);
    on<GetActiveSubscription>(_onGetActiveSubscription);
    on<VerifyLastPurchase>(_onVerifyLastPurchase);
    on<BuySubscription>(_onBuySubscription);
    on<PurchasedSubscription>(_onPurchasedSubscription);
    on<RestorePurchased>(_onRestorePurchased);
    on<ErrorPurchase>(_onErrorPurchase);
    on<GetAccountSubscription>(_onGetAccountSubscription);
    on<CanceledByUser>(_cancelledByUser);
    on<SubscriptionLogout>(_onLogout);
    on<SubscriptionDispose>(_onSubscriptionDispose);
    on<NotifySubscriptionExpired>(_onNotifySubscriptionExpired);
  }

  String get vendor => Platform.isIOS ? 'ios' : 'android';

  void initPurchaseStream() =>
      _purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscription(
        onError: (error) => add(SubscriptionEvent.errorPurchase(error)),
        onRestored: (purchase) => _checkEligibility
            ? add(SubscriptionEvent.setEligibility(
                isEligible: false, purchase: purchase))
            : _restoreTransactionData(purchase),
        onPurchased: (PurchaseDetails purchaseDetails) async =>
            _handlePurchase(purchaseDetails),
        onCanceled: () => add(const SubscriptionEvent.canceledByUser()),
        onEmpty: _onEmptyRestore,
      )..init();

  FutureOr<void> _onNotifySubscriptionExpired(
    NotifySubscriptionExpired event,
    Emitter<SubscriptionState> emit,
  ) async {
    log.i(
      'PURCHASED PRODUCT ${event.subscription.id} IS EXPIRED; timestamp: ${event.subscription.purchasedAt}',
      error: runtimeType,
    );
  }

  FutureOr<void> _processingDataPlans(
    ProcessingDataPlans event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(SubscriptionState.processedDataPlans(
        state.data.copyWith(isLoading: false)));
  }

  FutureOr<void> _onCheckEligibility(
    CheckEligibility event,
    Emitter<SubscriptionState> emit,
  ) async {
    initPurchaseStream();

    emit(const SubscriptionState.initial(SubscriptionStateData()));
    _checkEligibility = true;
    MixpanelEventService.instance.track(
      AppMixpanelEvents.checkEligibilityByUser,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
    if (Platform.isAndroid) {
      await _checkAndroidEligible();
    } else {
      _inAppPurchaseService.restorePurchase();
    }
  }

  Future<void> _checkAndroidEligible() async {
    final InAppPurchaseAndroidPlatformAddition androidAddition =
        _inAppPurchaseService.instance
            .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    final QueryPurchaseDetailsResponse oldPurchases =
        await androidAddition.queryPastPurchases();
    if (oldPurchases.pastPurchases.isNotEmpty) {
      add(SubscriptionEvent.setEligibility(
          isEligible: false, purchase: oldPurchases.pastPurchases.last));
    } else {
      _onEmptyRestore();
    }
  }

  Future<void> _onEmptyRestore() async {
    if (_checkEligibility) {
      add(
        const SubscriptionEvent.setEligibility(
          isEligible: true,
          purchase: null,
        ),
      );
    } else {
      add(
        const SubscriptionEvent.errorPurchase(
          RequestError.streamSubscription(
            ServerErrorData(message: LocalizedTexts.subscriptionEmptyToRestore),
          ),
        ),
      );
    }
  }

  FutureOr<void> _setEligibility(
    SetEligibility event,
    Emitter<SubscriptionState> emit,
  ) {
    _checkEligibility = false;
    emit(
      SubscriptionState.setEligibility(
        state.data.copyWith(
          isEligible: event.isEligible,
          lastPurchase: event.purchase,
        ),
      ),
    );
  }

  FutureOr<void> _onVerifyLastPurchase(
    VerifyLastPurchase event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionState.loading(state.data.copyWith(isLoading: true)));
    PurchaseDetails? oldPurchaseDetails;
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          _inAppPurchaseService.instance
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final QueryPurchaseDetailsResponse oldPurchases =
          await androidAddition.queryPastPurchases();
      if (oldPurchases.pastPurchases.isNotEmpty) {
        oldPurchaseDetails = oldPurchases.pastPurchases.last;
      }
      await _verifyOldPurchase(oldPurchaseDetails, event.product);
    } else {
      await _verifyOldPurchase(state.data.lastPurchase, event.product);
    }
  }

  Future<void> _verifyOldPurchase(
      PurchaseDetails? oldPurchaseDetails, ProductDetails product) async {
    late Either<RequestError, ValidStatus> response;
    response = await _verifyPurchaseFromHistory(oldPurchaseDetails);
    response.fold(
      (error) {
        _pushAnalyticErrorVerifyLastPurchase(product);
        add(SubscriptionEvent.errorPurchase(error));
      },
      (r) async {
        _mixpanelVerifyLastPurchaseEvent(
            data: oldPurchaseDetails, isValid: r.valid ?? true);
        if (r.valid ?? true) {
          add(SubscriptionEvent.buySubscription(product));
        } else {
          _pushAnalyticErrorVerifyLastPurchase(product);
          add(
            const SubscriptionEvent.errorPurchase(
              RequestError.streamSubscription(
                ServerErrorData(
                    message: LocalizedTexts.errorSomethingWentWrong),
              ),
            ),
          );
        }
      },
    );
  }

  Future<Either<RequestError, ValidStatus>> _verifyPurchaseFromHistory(
      PurchaseDetails? oldPurchaseDetails) async {
    if (oldPurchaseDetails == null) {
      return await _apiVerifiedEmpty();
    }
    return await _apiVerified(oldPurchaseDetails);
  }

  FutureOr<void> _onBuySubscription(
    BuySubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    _pushAnalyticStartPurchase(event);
    try {
      _pushAnalyticStartPurchase(event);
      final purchased =
          await _inAppPurchaseService.buyItemInStore(event.product);
      if (purchased) {
        emit(
          SubscriptionState.loading(
            state.data.copyWith(
              product: event.product,
            ),
          ),
        );
      } else {
        MixpanelEventService.instance.track(
          AppMixpanelEvents.subscriptionPurchaseError,
          parameters: {
            AnalyticsParameters.productIdentifier: event.product.id,
            AnalyticsParameters.errorMessage: 'error_purchase_message',
          },
        );
        emit(
          SubscriptionState.error(
            state.data.copyWith(
              error: const RequestError.streamSubscription(
                ServerErrorData(
                    message: LocalizedTexts.errorPurchaseErrorMessage),
              ),
              isLoading: false,
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
              ServerErrorData(
                  message: LocalizedTexts.errorPurchaseErrorMessage),
            ),
            isLoading: false,
          ),
        ),
      );
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    await _verifyPurchasedOrRestore(purchaseDetails);
  }

  Future<void> _verifyPurchasedOrRestore(PurchaseDetails purchaseDetails,
      {bool isRestore = false}) async {
    final response = await _apiPurchaseOrRestore(purchaseDetails);
    response.fold((error) {
      _pushAnalyticErrorVerifyOnServer(purchaseDetails);
      MixpanelEventService.instance.track(
        AppMixpanelEvents.sendValidationPurchaseOnBackendError,
        parameters: {AnalyticsParameters.errorMessage: error.message},
      );
      add(SubscriptionEvent.errorPurchase(error));
    }, (r) async {
      if (r.isActive) {
        await _purchasedSuccess(purchaseDetails, r);
      } else if (!r.isActive && isRestore) {
        add(
          const SubscriptionEvent.errorPurchase(
            RequestError.streamSubscription(
              ServerErrorData(
                  message: LocalizedTexts.subscriptionEmptyToRestore),
            ),
          ),
        );
      } else {
        add(SubscriptionEvent.notifySubscriptionExpired(subscription: r));
      }
    });
  }

  Future<void> _purchasedSuccess(
      PurchaseDetails purchaseDetails, Subscription r) async {
    MixpanelEventService.instance.track(
      AppMixpanelEvents.userPurchasedSubscription,
      parameters: {
        AnalyticsParameters.productIdentifier: purchaseDetails.productID,
        AnalyticsParameters.purchaseIdentifier: purchaseDetails.purchaseID,
        AnalyticsParameters.purchaseStatus: purchaseDetails.status.name,
        AnalyticsParameters.transactionDate:
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(purchaseDetails.transactionDate!) * 1000),
      },
    );
    MixpanelEventService.instance
        .track(AppMixpanelEvents.sendValidationPurchaseOnBackendSuccess);
    final accessTokenUpdated = await _authTokenManager.updateAccessToken();
    if (accessTokenUpdated) {
      _pushAnalyticBoughtEvent(purchaseDetails, r);
      add(
        SubscriptionEvent.purchasedSubscription(
          r,
          PurchasedProduct(
            purchaseDetails: purchaseDetails,
            memberSince:
                SubscriptionDateUtils.getTransactionDate(r.purchasedAt),
          ),
        ),
      );
    } else {
      MixpanelEventService.instance
          .track(AppMixpanelEvents.getAccessTokenWithSubscriptionError);
      add(
        const SubscriptionEvent.errorPurchase(
          RequestError.streamSubscription(
            ServerErrorData(
                message: LocalizedTexts.errorPurchaseVerificationError),
          ),
        ),
      );
    }
  }

  Future<Either<RequestError, Subscription>> _apiPurchaseOrRestore(
      PurchaseDetails purchaseDetails) async {
    var isIOS = purchaseDetails is AppStorePurchaseDetails;
    final identifier = _getTransactionId(purchaseDetails) ?? '';
    MixpanelEventService.instance.track(
      AppMixpanelEvents.sendValidationPurchaseOnBackend,
      parameters: {
        AnalyticsParameters.productIdentifier: purchaseDetails.productID,
        AnalyticsParameters.purchaseIdentifier: purchaseDetails.purchaseID,
        AnalyticsParameters.purchaseStatus: purchaseDetails.status.name,
        if (purchaseDetails.transactionDate != null)
          AnalyticsParameters.transactionDate:
              DateTime.fromMillisecondsSinceEpoch(
                  int.parse(purchaseDetails.transactionDate!) * 1000),
      },
    );
    var response = isIOS
        ? await _purchaseService.purchaseIOS(
            VerifyIOSPurchaseData(
                receipt:
                    purchaseDetails.verificationData.serverVerificationData,
                transactionId: identifier),
            vendor)
        : await _purchaseService.purchaseAndroid(
            VerifyAndroidPurchaseData(
                receipt:
                    purchaseDetails.verificationData.serverVerificationData,
                purchaseToken: identifier),
            vendor);
    return response;
  }

  Future<Either<RequestError, ValidStatus>> _apiVerifiedEmpty() async {
    var response = Platform.isIOS
        ? await _purchaseService.verifyPurchaseIOS(null, vendor)
        : await _purchaseService.verifyPurchaseAndroid(null, vendor);
    return response;
  }

  Future<Either<RequestError, ValidStatus>> _apiVerified(
      PurchaseDetails purchaseDetails) async {
    var isIOS = purchaseDetails is AppStorePurchaseDetails;
    final identifier = _getTransactionId(purchaseDetails) ?? '';
    var response = isIOS
        ? await _purchaseService.verifyPurchaseIOS(
            VerifyIOSPurchaseData(
                receipt:
                    purchaseDetails.verificationData.serverVerificationData,
                transactionId: identifier),
            vendor)
        : await _purchaseService.verifyPurchaseAndroid(
            VerifyAndroidPurchaseData(
                receipt:
                    purchaseDetails.verificationData.serverVerificationData,
                purchaseToken: identifier),
            vendor);
    return response;
  }

  void _restoreTransactionData(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status != PurchaseStatus.restored) {
      return;
    }
    await _verifyPurchasedOrRestore(purchaseDetails, isRestore: true);
  }

  String? _getTransactionId(PurchaseDetails purchaseDetails) {
    if (purchaseDetails is AppStorePurchaseDetails) {
      return purchaseDetails.skPaymentTransaction.transactionIdentifier;
    } else if (purchaseDetails is GooglePlayPurchaseDetails) {
      return purchaseDetails.billingClientPurchase.purchaseToken;
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
    _checkEligibility = false;
    emit(SubscriptionState.loading(state.data.copyWith(isLoading: true)));
    MixpanelEventService.instance.track(AppMixpanelEvents.userClickRestore);
    _inAppPurchaseService.restorePurchase();
  }

  FutureOr<void> _onGetPlansFromServer(
    GetPlansFromServer event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
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
      MixpanelEventService.instance.track(
        AppMixpanelEvents.getSubscriptionIdsBackend,
        parameters: {
          AnalyticsParameters.purchaseProductIds:
              serverList.map((plan) => plan.productId).toString(),
        },
      );
      emit(
        SubscriptionState.loading(
            state.data.copyWith(isLoading: false, serverPlans: serverList)),
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

    final plans = await _inAppPurchaseService.getSubscriptionPlans(products);
    if (plans.isEmpty) {
      emit(SubscriptionState.serviceSubscriptionUnavailable(
          state.data.copyWith(isLoading: false)));
    } else {
      MixpanelEventService.instance.track(
        AppMixpanelEvents.getSubscriptionPansStore,
        parameters: {
          AnalyticsParameters.purchaseProductIds:
              plans.map((plan) => plan.id).toString(),
        },
      );
      List<ProductDetails> list = [
        ...(Platform.isAndroid
            ? _getUniqueAndroidPlans(plans)
            : _getIosPlans(plans))
      ];

      MixpanelEventService.instance.track(
        AppMixpanelEvents.getUserAvailableSubscriptions,
        parameters: {
          AnalyticsParameters.purchaseProductIds:
              list.map((plan) => plan.id).toString(),
        },
      );
      emit(
        SubscriptionState.successInPlans(
            state.data.copyWith(isLoading: false, plans: list)),
      );
      add(const SubscriptionEvent.getActiveSubscription());
    }
  }

  List<ProductDetails> _getUniqueAndroidPlans(List<ProductDetails> plans) {
    if (plans.isEmpty) {
      return [];
    }
    final map = plans.groupBy((plan) => plan.id);

    List<ProductDetails> list = map.entries
        .map((list) => list.value.reduce((curr, next) =>
            curr.rawPrice.toInt() < next.rawPrice.toInt() ? next : curr))
        .toList();
    List<ProductDetails> orderList = [];

    for (var plan in list) {
      if (state.data.serverPlans
          .any((serverPlan) => serverPlan.productId == plan.id)) {
        orderList.add(plan);
      }
    }
    return orderList;
  }

  List<ProductDetails> _getIosPlans(List<ProductDetails> plans) {
    if (plans.isEmpty) {
      return [];
    }
    List<ProductDetails> list = [...plans];
    list.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
    return list;
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
      (error) => emit(SubscriptionState.error(
          state.data.copyWith(error: error, isLoading: false))),
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
        emit(SubscriptionState.error(
            state.data.copyWith(error: error, isLoading: false)));
      },
      (r) {
        final subscription = r.subscription;
        emit(
          SubscriptionState.loading(state.data.copyWith(isLoading: false)),
        );
        switch (subscription.state) {
          case SubscriptionStatus.trialPeriod:
          case SubscriptionStatus.common:
          case SubscriptionStatus.cancelled:
          case SubscriptionStatus.refunded:
            if (subscription.isActive) {
              emit(SubscriptionState.subscriptionActive(
                  state.data.copyWith(subscription: subscription)));
            } else if (!subscription.isActive &&
                SubscriptionDateUtils.isPassDate(subscription.expiresAt)) {
              _emitSubscriptionState(emit, subscription);
            }
            break;
          case SubscriptionStatus.gracePeriod:
            if (subscription.isActive) {
              emit(SubscriptionState.subscriptionUnRenewed(
                  state.data.copyWith(subscription: subscription)));
            } else {
              _emitSubscriptionState(emit, subscription);
            }
            break;
          default:
            _emitSubscriptionState(emit, subscription);
            break;
        }
      },
    );
  }

  void _emitSubscriptionState(
      Emitter<SubscriptionState> emit, Subscription subscription) {
    // Todo will bw updated with new requirements for multiple subscriptionSubscribe
    // if (state.data.plans.length == 1) {
    emit(SubscriptionState.singlePlan(
        state.data.copyWith(subscription: subscription)));
    // } else {
    //   emit(SubscriptionState.multiplePlans(state.data.copyWith(subscription: subscription)));
    // }
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
    _purchaseDetailsStreamSubscription.close();
    emit(SubscriptionState.success(state.data));
  }

  FutureOr<void> _onLogout(
    SubscriptionLogout event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionState.loading(state.data.copyWith(isLoading: true)));
    _purchaseDetailsStreamSubscription.close();
    CustomerIoService.logOut();
    emit(SubscriptionState.logout(state.data.copyWith(isLoading: false)));
  }

  FutureOr<void> _cancelledByUser(
    CanceledByUser event,
    Emitter<SubscriptionState> emit,
  ) async {
    usageAnalytics.track(
      eventName: AnalyticsEvents.subscriptionUserClosePurchaseDialog,
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: AnalyticsEvents.subscriptionUserClosePurchaseDialog,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
    MixpanelEventService.instance.track(
      AppMixpanelEvents.userCancelSubscriptionPurchase,
    );
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: false)),
    );
  }

  void _pushAnalyticStartPurchase(BuySubscription event) {
    usageAnalytics.track(
      eventName: AnalyticsEvents.subscriptionStartPurchase,
      attributes: {
        UsageAnalyticsAttributes.identifierOption: event.product.id,
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
    usageAnalytics.track(
      eventName: AnalyticsEvents.subscriptionErrorVerifyLastPurchaseOnServer,
      attributes: {
        UsageAnalyticsAttributes.identifierOption: product.id,
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
    usageAnalytics.track(
      eventName: AnalyticsEvents.subscriptionDuplicatePurchase,
      attributes: {
        UsageAnalyticsAttributes.identifierOption: event.product.id,
      },
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: AnalyticsEvents.subscriptionDuplicatePurchase,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        AnalyticsParameters.productIdentifier: event.product.id,
      },
    );
    MixpanelEventService.instance.track(
      AppMixpanelEvents.subscriptionPurchaseError,
      parameters: {
        AnalyticsParameters.productIdentifier: event.product.id,
        AnalyticsParameters.errorMessage:
            'store_subscription_duplicate_purchase',
      },
    );
  }

  void _pushAnalyticErrorVerifyOnServer(PurchaseDetails purchaseDetails) {
    usageAnalytics.track(
      eventName: AnalyticsEvents.subscriptionErrorVerifyOnServer,
      attributes: {
        UsageAnalyticsAttributes.identifierOption: purchaseDetails.productID,
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

  void _pushAnalyticBoughtEvent(
      PurchaseDetails purchaseDetails, Subscription r) {
    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.subscriptionBought,
      attributes: {
        UsageAnalyticsAttributes.identifierOption: purchaseDetails.productID,
        UsageAnalyticsAttributes.subscriptionExpirationDate: r.expiresAt,
      },
    );

    const AnalyticsEventService.uxcam().logEvent(
      eventName: UsageAnalyticsEvents.subscriptionBought,
      parameters: {
        AnalyticsParameters.productIdentifier: purchaseDetails.productID,
        UsageAnalyticsAttributes.subscriptionExpirationDate: r.expiresAt,
      },
    );
    final identifier = _getTransactionId(purchaseDetails) ?? '';

    final price = state.data.product?.price;
    final currencyCode = state.data.product?.currencyCode;

    FacebookEventsService.logEvent(
      eventName: '${AnalyticsEvents.subscriptionBought}_${price}_$currencyCode',
      parameters: {
        AnalyticsParameters.subscriptionRevenue: state.data.product?.price,
        AnalyticsParameters.subscriptionCurrencyCode:
            state.data.product?.currencyCode,
        AnalyticsParameters.subscriptionContentId: purchaseDetails.purchaseID,
        AnalyticsParameters.subscriptionTransactionId: identifier,
        AnalyticsParameters.subscriptionContentType: purchaseDetails.productID,
        AnalyticsParameters.subscriptionEventTime: r.purchasedAt,
      },
    );
    MixpanelEventService.instance
        .track(AppMixpanelEvents.getAccessTokenWithSubscriptionSuccess);
  }

  String _getMixpanelEventName(bool? isValid) {
    if (isValid == null) {
      return AppMixpanelEvents.userLastTransactionValidationBackend;
    }
    if (isValid) {
      return AppMixpanelEvents.userLastTransactionValidationSuccess;
    }
    return AppMixpanelEvents.userLastTransactionValidationError;
  }

  void _mixpanelVerifyLastPurchaseEvent(
      {PurchaseDetails? data, bool? isValid}) {
    MixpanelEventService.instance.track(
      _getMixpanelEventName(isValid),
      parameters: {
        if (data != null) ...{
          AnalyticsParameters.productIdentifier: data.productID,
          AnalyticsParameters.purchaseIdentifier: data.purchaseID,
          AnalyticsParameters.purchaseStatus: data.status.name,
          if (data.transactionDate != null)
            AnalyticsParameters.transactionDate:
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(data.transactionDate!) * 1000),
        },
        if (isValid != null) AnalyticsParameters.lastPurchaseValid: isValid,
      },
    );
  }
}
