import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_plan_content_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_plan_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_services_v2.dart';

// import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/events.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
// import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/subscription/domain/server_product.dart';
import 'package:loopcare_frontend/features/subscription/domain/services/purchase_service.dart';
// import '../infrastructure/purchase_details_subscription_v2.dart';
// import '../infrastructure/subscription_service_v2.dart';

part 'subscription_v2_event.dart';
part 'subscription_v2_state.dart';
part 'subscription_v2_bloc.freezed.dart';

@singleton
class SubscriptionV2Bloc extends Bloc<SubscriptionV2Event, SubscriptionV2State> {
  final SubscriptionServicesV2 _subscriptionServicesV2;
  // late PurchaseDetailsStreamSubscriptionV2 _purchaseDetailsStreamSubscription;
  // final AuthenticationService _authenticationService;
  // final AppSubscriptionServiceV2 _inAppPurchaseService;

  final PurchaseService _purchaseService;
  // final AuthTokenManager _authTokenManager;
  final usageAnalytics = UsageAnalytics();
  // bool _checkEligibility = false;

  SubscriptionV2Bloc(
    this._subscriptionServicesV2,
    this._purchaseService,
  ) : super(SubscriptionV2State.initial(SubscriptionV2StateData())) {
    on<GetPlans>(_onGetPlans);
    on<OnCheckedPlan>(_onCheckedPlan);
    on<GetServerPlans>(_onGetServerPlans);
    // on<SubscriptionV2Init>(_onInitSubscription);
    // on<CheckEligibilityV2>(_onCheckEligibility);
    // on<SetEligibilityV2>(_setEligibility);
    // on<GetSubscriptionPlansV2>(_onGetSubscriptionPlans);
    // on<ProcessingDataPlansV2>(_processingDataPlans);
    // on<GetActiveSubscriptionV2>(_onGetActiveSubscription);
    // on<VerifyLastPurchaseV2>(_onVerifyLastPurchase);
    // on<BuySubscriptionV2>(_onBuySubscription);
    // on<PurchasedSubscriptionV2>(_onPurchasedSubscription);
    // on<RestorePurchasedV2>(_onRestorePurchased);
    // on<ErrorPurchaseV2>(_onErrorPurchase);
    // on<GetAccountSubscriptionV2>(_onGetAccountSubscription);
    // on<CanceledByUserV2>(_cancelledByUser);
    // on<SubscriptionLogoutV2>(_onLogout);
    // on<SubscriptionDisposeV2>(_onSubscriptionDispose);
    // on<NotifySubscriptionExpiredV2>(_onNotifySubscriptionExpired);
  }

  String get vendor => Platform.isIOS ? 'ios' : 'android';

  Future<void> _onGetPlans(
    GetPlans event,
    Emitter<SubscriptionV2State> emit,
  ) async {
    emit(SubscriptionV2State.loading(state.data.copyWith(isLoading: true)));

    final response = await _subscriptionServicesV2.getPlans();

    response.fold(
        (left) =>
            emit(SubscriptionV2State.error(state.data.copyWith(error: left, isLoading: false))),
        (right) {
      emit(SubscriptionV2State.loaded(state.data.copyWith(
        id: right.id,
        type: right.type,
        title: right.title,
        label: right.label,
        subText: right.subText,
        plans: right.plans,
      )));
    });
  }

  Future<void> _onCheckedPlan(
    OnCheckedPlan event,
    Emitter<SubscriptionV2State> emit,
  ) async {
    emit(SubscriptionV2State.loaded(
        state.data.copyWith(checkedId: event.checkedId, onChecked: event.onChecked)));
  }

  FutureOr<void> _onGetServerPlans(
    GetServerPlans event,
    Emitter<SubscriptionV2State> emit,
  ) async {
    emit(
      SubscriptionV2State.loading(state.data.copyWith(isLoading: true)),
    );
    var response = await _purchaseService.getProductList(vendor);
    response.fold((error) {
      emit(
        SubscriptionV2State.error(
          state.data.copyWith(
            error: error,
            isLoading: false,
          ),
        ),
      );
    }, (r) {
      List<ServerProduct> serverList2 = [...r.data];
      serverList2.sort((a, b) => a.price!.toInt().compareTo(b.price!.toInt()));

      MixpanelEventService.instance.track(
        AppMixpanelEvents.getSubscriptionIdsBackend,
        parameters: {
          AnalyticsParameters.purchaseProductIds:
              serverList2.map((plan) => plan.productId).toString(),
        },
      );
      emit(
        SubscriptionV2State.loading(
            state.data.copyWith(isLoading: false, serverPlans: serverList2)),
      );
      add(const SubscriptionV2Event.getSubscriptionPlans());
    });
  }

  // FutureOr<void> _onInitSubscription(
  //   SubscriptionV2Init event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   emit(SubscriptionV2State.initial(SubscriptionV2StateData()));
  // }

  // FutureOr<void> _onCheckEligibility(
  //   CheckEligibilityV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   initPurchaseStream();
  //
  //   emit(SubscriptionV2State.initial(SubscriptionV2StateData()));
  //   _checkEligibility = true;
  //   MixpanelEventService.instance.track(
  //     AppMixpanelEvents.checkEligibilityByUser,
  //     parameters: {
  //       AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
  //     },
  //   );
  //   if (Platform.isAndroid) {
  //     await _checkAndroidEligible();
  //   } else {
  //     _inAppPurchaseService.restorePurchase();
  //   }
  // }
  //
  // FutureOr<void> _setEligibility(
  //   SetEligibilityV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) {
  //   _checkEligibility = false;
  //   emit(
  //     SubscriptionV2State.setEligibility(
  //       state.data.copyWith(
  //         isEligible: event.isEligible,
  //         lastPurchase: event.purchase,
  //       ),
  //     ),
  //   );
  // }
  //
  // FutureOr<void> _onGetSubscriptionPlans(
  //   GetSubscriptionPlansV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   emit(SubscriptionV2State.loading(state.data.copyWith(isLoading: true)));
  //   Set<String> products = {};
  //   for (final product in state.data.serverPlans) {
  //     products.add(product.productId!);
  //     log.i(
  //       'PRODUCT: ${product.productId}',
  //       error: LogTitle.subscription,
  //     );
  //   }
  //
  //   final plans = await _inAppPurchaseService.getSubscriptionPlans(products);
  //   if (plans.isEmpty) {
  //     emit(SubscriptionV2State.serviceSubscriptionUnavailable(state.data.copyWith(isLoading: false)));
  //   } else {
  //     MixpanelEventService.instance.track(
  //       AppMixpanelEvents.getSubscriptionPansStore,
  //       parameters: {
  //         AnalyticsParameters.purchaseProductIds: plans.map((plan) => plan.id).toString(),
  //       },
  //     );
  //     List<ProductDetails> list = [...(Platform.isAndroid ? _getUniqueAndroidPlans(plans) : _getIosPlans(plans))];
  //
  //     MixpanelEventService.instance.track(
  //       AppMixpanelEvents.getUserAvailableSubscriptions,
  //       parameters: {
  //         AnalyticsParameters.purchaseProductIds: list.map((plan) => plan.id).toString(),
  //       },
  //     );
  //     emit(
  //       SubscriptionV2State.successInPlans(state.data.copyWith(isLoading: false, plans2: list)),
  //     );
  //     add(const SubscriptionV2Event.getActiveSubscriptionV2());
  //   }
  // }
  //
  // FutureOr<void> _processingDataPlans(
  //   ProcessingDataPlansV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) {
  //   emit(SubscriptionV2State.processedDataPlans(state.data.copyWith(isLoading: false)));
  // }
  //
  // Future<void> _onGetActiveSubscription(
  //   GetActiveSubscriptionV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   emit(
  //     SubscriptionV2State.loading(state.data.copyWith(isLoading: true)),
  //   );
  //   final response = await _authenticationService.fetchAccount();
  //   response.fold(
  //     (error) {
  //       emit(SubscriptionV2State.error(state.data.copyWith(error: error, isLoading: false)));
  //     },
  //     (r) {
  //       final subscription = r.subscription;
  //       emit(
  //         SubscriptionV2State.loading(state.data.copyWith(isLoading: false)),
  //       );
  //       switch (subscription.state) {
  //         case SubscriptionStatus.trialPeriod:
  //         case SubscriptionStatus.common:
  //         case SubscriptionStatus.cancelled:
  //         case SubscriptionStatus.refunded:
  //           if (subscription.isActive) {
  //             emit(SubscriptionV2State.subscriptionActive(state.data.copyWith(subscription: subscription)));
  //           } else if (!subscription.isActive && SubscriptionDateUtils.isPassDate(subscription.expiresAt)) {
  //             _emitSubscriptionState(emit, subscription);
  //           }
  //           break;
  //         case SubscriptionStatus.gracePeriod:
  //           if (subscription.isActive) {
  //             emit(SubscriptionV2State.subscriptionUnRenewed(state.data.copyWith(subscription: subscription)));
  //           } else {
  //             _emitSubscriptionState(emit, subscription);
  //           }
  //           break;
  //         default:
  //           _emitSubscriptionState(emit, subscription);
  //           break;
  //       }
  //     },
  //   );
  // }
  //
  // FutureOr<void> _onVerifyLastPurchase(
  //   VerifyLastPurchaseV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   emit(SubscriptionV2State.loading(state.data.copyWith(isLoading: true)));
  //   PurchaseDetails? oldPurchaseDetails;
  //   if (Platform.isAndroid) {
  //     final InAppPurchaseAndroidPlatformAddition androidAddition =
  //         _inAppPurchaseService.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
  //     final QueryPurchaseDetailsResponse oldPurchases = await androidAddition.queryPastPurchases();
  //     if (oldPurchases.pastPurchases.isNotEmpty) {
  //       oldPurchaseDetails = oldPurchases.pastPurchases.last;
  //     }
  //     await _verifyOldPurchase(oldPurchaseDetails, event.product);
  //   } else {
  //     await _verifyOldPurchase(state.data.lastPurchase, event.product);
  //   }
  // }
  //
  // FutureOr<void> _onBuySubscription(
  //   BuySubscriptionV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   _pushAnalyticStartPurchase(event);
  //   try {
  //     _pushAnalyticStartPurchase(event);
  //     final purchased = await _inAppPurchaseService.buyItemInStore(event.product);
  //     if (purchased) {
  //       emit(
  //         SubscriptionV2State.loading(
  //           state.data.copyWith(
  //             product: event.product,
  //           ),
  //         ),
  //       );
  //     } else {
  //       MixpanelEventService.instance.track(
  //         AppMixpanelEvents.subscriptionPurchaseError,
  //         parameters: {
  //           AnalyticsParameters.productIdentifier: event.product.id,
  //           AnalyticsParameters.errorMessage: 'error_purchase_message',
  //         },
  //       );
  //       emit(
  //         SubscriptionV2State.error(
  //           state.data.copyWith(
  //             error: const RequestError.streamSubscription(
  //               ServerErrorData(message: LocalizedTexts.errorPurchaseErrorMessage),
  //             ),
  //             isLoading: false,
  //           ),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     _pushAnalyticDuplicatePurchase(event);
  //     emit(
  //       SubscriptionV2State.purchaseDuplicateSubscription(
  //         state.data.copyWith(
  //           error: const RequestError.streamSubscription(
  //             ServerErrorData(message: LocalizedTexts.errorPurchaseErrorMessage),
  //           ),
  //           isLoading: false,
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  // FutureOr<void> _onPurchasedSubscription(
  //   PurchasedSubscriptionV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async =>
  //     emit(
  //       SubscriptionV2State.purchasedSubscription(
  //         state.data.copyWith(
  //           purchased: event.purchasedProduct,
  //           subscription: event.subscription,
  //           isLoading: false,
  //         ),
  //       ),
  //     );
  //
  // FutureOr<void> _onRestorePurchased(
  //   RestorePurchasedV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) {
  //   _checkEligibility = false;
  //   emit(SubscriptionV2State.loading(state.data.copyWith(isLoading: true)));
  //   MixpanelEventService.instance.track(AppMixpanelEvents.userClickRestore);
  //   _inAppPurchaseService.restorePurchase();
  // }
  //
  // FutureOr<void> _onErrorPurchase(
  //   ErrorPurchaseV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async =>
  //     emit(
  //       SubscriptionV2State.error(
  //         state.data.copyWith(
  //           error: event.error,
  //           isLoading: false,
  //         ),
  //       ),
  //     );
  //
  // FutureOr<void> _onGetAccountSubscription(
  //   GetAccountSubscriptionV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   emit(
  //     SubscriptionV2State.loading(state.data.copyWith(isLoading: true)),
  //   );
  //   final response = await _authenticationService.fetchAccount();
  //   response.fold(
  //     (error) => emit(SubscriptionV2State.error(state.data.copyWith(error: error, isLoading: false))),
  //     (r) => emit(
  //       SubscriptionV2State.gotAccountSubscription(
  //         state.data.copyWith(isLoading: false, subscription: r.subscription),
  //       ),
  //     ),
  //   );
  // }
  //
  // FutureOr<void> _cancelledByUser(
  //   CanceledByUserV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   usageAnalytics.track(
  //     eventName: AnalyticsEvents.subscriptionUserClosePurchaseDialog,
  //   );
  //   const AnalyticsEventService.uxcam().logEvent(
  //     eventName: AnalyticsEvents.subscriptionUserClosePurchaseDialog,
  //     parameters: {
  //       AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
  //     },
  //   );
  //   MixpanelEventService.instance.track(
  //     AppMixpanelEvents.userCancelSubscriptionPurchase,
  //   );
  //   emit(
  //     SubscriptionV2State.loading(state.data.copyWith(isLoading: false)),
  //   );
  // }
  //
  // FutureOr<void> _onLogout(
  //   SubscriptionLogoutV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   emit(SubscriptionV2State.loading(state.data.copyWith(isLoading: true)));
  //   _purchaseDetailsStreamSubscription.close();
  //   CustomerIoService.logOut();
  //   emit(SubscriptionV2State.logout(state.data.copyWith(isLoading: false)));
  // }
  //
  // FutureOr<void> _onSubscriptionDispose(
  //   SubscriptionDisposeV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) {
  //   _purchaseDetailsStreamSubscription.close();
  //   emit(SubscriptionV2State.success(state.data));
  // }
  //
  // FutureOr<void> _onNotifySubscriptionExpired(
  //   NotifySubscriptionExpiredV2 event,
  //   Emitter<SubscriptionV2State> emit,
  // ) async {
  //   log.i(
  //     'PURCHASED PRODUCT ${event.subscription.id} IS EXPIRED; timestamp: ${event.subscription.purchasedAt}',
  //     error: runtimeType,
  //   );
  // }
  //
  // void _pushAnalyticStartPurchase(BuySubscriptionV2 event) {
  //   usageAnalytics.track(
  //     eventName: AnalyticsEvents.subscriptionStartPurchase,
  //     attributes: {
  //       UsageAnalyticsAttributes.identifierOption: event.product.id,
  //     },
  //   );
  //   const AnalyticsEventService.uxcam().logEvent(
  //     eventName: AnalyticsEvents.subscriptionStartPurchase,
  //     parameters: {
  //       AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
  //       AnalyticsParameters.productIdentifier: event.product.id,
  //     },
  //   );
  // }
  //
  // void _pushAnalyticDuplicatePurchase(BuySubscriptionV2 event) {
  //   usageAnalytics.track(
  //     eventName: AnalyticsEvents.subscriptionDuplicatePurchase,
  //     attributes: {
  //       UsageAnalyticsAttributes.identifierOption: event.product.id,
  //     },
  //   );
  //   const AnalyticsEventService.uxcam().logEvent(
  //     eventName: AnalyticsEvents.subscriptionDuplicatePurchase,
  //     parameters: {
  //       AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
  //       AnalyticsParameters.productIdentifier: event.product.id,
  //     },
  //   );
  //   MixpanelEventService.instance.track(
  //     AppMixpanelEvents.subscriptionPurchaseError,
  //     parameters: {
  //       AnalyticsParameters.productIdentifier: event.product.id,
  //       AnalyticsParameters.errorMessage: 'store_subscription_duplicate_purchase',
  //     },
  //   );
  // }
  //
  // Future<void> _verifyOldPurchase(PurchaseDetails? oldPurchaseDetails, ProductDetails product) async {
  //   late Either<RequestError, ValidStatus> response;
  //   response = await _verifyPurchaseFromHistory(oldPurchaseDetails);
  //   response.fold(
  //     (error) {
  //       _pushAnalyticErrorVerifyLastPurchase(product);
  //       add(SubscriptionV2Event.errorPurchase(error));
  //     },
  //     (r) async {
  //       _mixpanelVerifyLastPurchaseEvent(data: oldPurchaseDetails, isValid: r.valid ?? true);
  //       if (r.valid ?? true) {
  //         add(SubscriptionV2Event.buySubscription(product));
  //       } else {
  //         _pushAnalyticErrorVerifyLastPurchase(product);
  //         add(
  //           const SubscriptionV2Event.errorPurchase(
  //             RequestError.streamSubscription(
  //               ServerErrorData(message: LocalizedTexts.errorSomethingWentWrong),
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
  //
  // void _pushAnalyticErrorVerifyLastPurchase(ProductDetails product) {
  //   usageAnalytics.track(
  //     eventName: AnalyticsEvents.subscriptionErrorVerifyLastPurchaseOnServer,
  //     attributes: {
  //       UsageAnalyticsAttributes.identifierOption: product.id,
  //     },
  //   );
  //   const AnalyticsEventService.uxcam().logEvent(
  //     eventName: AnalyticsEvents.subscriptionErrorVerifyLastPurchaseOnServer,
  //     parameters: {
  //       AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
  //       AnalyticsParameters.productIdentifier: product.id,
  //     },
  //   );
  // }
  //
  // void _mixpanelVerifyLastPurchaseEvent({PurchaseDetails? data, bool? isValid}) {
  //   MixpanelEventService.instance.track(
  //     _getMixpanelEventName(isValid),
  //     parameters: {
  //       if (data != null) ...{
  //         AnalyticsParameters.productIdentifier: data.productID,
  //         AnalyticsParameters.purchaseIdentifier: data.purchaseID,
  //         AnalyticsParameters.purchaseStatus: data.status.name,
  //         if (data.transactionDate != null)
  //           AnalyticsParameters.transactionDate: DateTime.fromMillisecondsSinceEpoch(int.parse(data.transactionDate!) * 1000),
  //       },
  //       if (isValid != null) AnalyticsParameters.lastPurchaseValid: isValid,
  //     },
  //   );
  // }
  //
  // String _getMixpanelEventName(bool? isValid) {
  //   if (isValid == null) {
  //     return AppMixpanelEvents.userLastTransactionValidationBackend;
  //   }
  //   if (isValid) {
  //     return AppMixpanelEvents.userLastTransactionValidationSuccess;
  //   }
  //   return AppMixpanelEvents.userLastTransactionValidationError;
  // }
  //
  // Future<Either<RequestError, ValidStatus>> _verifyPurchaseFromHistory(PurchaseDetails? oldPurchaseDetails) async {
  //   if (oldPurchaseDetails == null) {
  //     return await _apiVerifiedEmpty();
  //   }
  //   return await _apiVerified(oldPurchaseDetails);
  // }
  //
  // Future<Either<RequestError, ValidStatus>> _apiVerified(PurchaseDetails purchaseDetails) async {
  //   var isIOS = purchaseDetails is AppStorePurchaseDetails;
  //   final identifier = _getTransactionId(purchaseDetails) ?? '';
  //   var response = isIOS
  //       ? await _purchaseService.verifyPurchaseIOS(
  //           VerifyIOSPurchaseData(receipt: purchaseDetails.verificationData.serverVerificationData, transactionId: identifier), vendor)
  //       : await _purchaseService.verifyPurchaseAndroid(
  //           VerifyAndroidPurchaseData(receipt: purchaseDetails.verificationData.serverVerificationData, purchaseToken: identifier), vendor);
  //   return response;
  // }
  //
  // Future<Either<RequestError, ValidStatus>> _apiVerifiedEmpty() async {
  //   var response =
  //       Platform.isIOS ? await _purchaseService.verifyPurchaseIOS(null, vendor) : await _purchaseService.verifyPurchaseAndroid(null, vendor);
  //   return response;
  // }
  //
  // void _emitSubscriptionState(Emitter<SubscriptionV2State> emit, Subscription subscription) {
  //   // Todo will bw updated with new requirements for multiple subscriptionSubscribe
  //   // if (state.data.plans.length == 1) {
  //   // emit(SubscriptionV2State.processedDataPlans(state.data.copyWith(subscription: subscription)));
  //   // } else {
  //   //   emit(SubscriptionState.multiplePlans(state.data.copyWith(subscription: subscription)));
  //   // }
  // }
  //
  // Future<void> _checkAndroidEligible() async {
  //   final InAppPurchaseAndroidPlatformAddition androidAddition =
  //       _inAppPurchaseService.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
  //   final QueryPurchaseDetailsResponse oldPurchases = await androidAddition.queryPastPurchases();
  //   if (oldPurchases.pastPurchases.isNotEmpty) {
  //     add(SubscriptionV2Event.setEligibility(isEligible: false, purchase: oldPurchases.pastPurchases.last));
  //   } else {
  //     _onEmptyRestore();
  //   }
  // }
  //
  // Future<void> _onEmptyRestore() async {
  //   if (_checkEligibility) {
  //     add(
  //       const SubscriptionV2Event.setEligibility(
  //         isEligible: true,
  //         purchase: null,
  //       ),
  //     );
  //   } else {
  //     add(
  //       const SubscriptionV2Event.errorPurchase(
  //         RequestError.streamSubscription(
  //           ServerErrorData(message: LocalizedTexts.subscriptionEmptyToRestore),
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  // void initPurchaseStream() => _purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscriptionV2(
  //       onError: (error) => add(SubscriptionV2Event.errorPurchase(error)),
  //       onRestored: (purchase) =>
  //           _checkEligibility ? add(SubscriptionV2Event.setEligibility(isEligible: false, purchase: purchase)) : _restoreTransactionData(purchase),
  //       onPurchased: (PurchaseDetails purchaseDetails) async => _handlePurchase(purchaseDetails),
  //       onCanceled: () => add(const SubscriptionV2Event.canceledByUser()),
  //       onEmpty: _onEmptyRestore,
  //     )..init();
  //
  // void _restoreTransactionData(PurchaseDetails purchaseDetails) async {
  //   if (purchaseDetails.status != PurchaseStatus.restored) {
  //     return;
  //   }
  //   await _verifyPurchasedOrRestore(purchaseDetails, isRestore: true);
  // }
  //
  // Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
  //   await _verifyPurchasedOrRestore(purchaseDetails);
  // }
  //
  // Future<void> _verifyPurchasedOrRestore(PurchaseDetails purchaseDetails, {bool isRestore = false}) async {
  //   final response = await _apiPurchaseOrRestore(purchaseDetails);
  //   response.fold((error) {
  //     _pushAnalyticErrorVerifyOnServer(purchaseDetails);
  //     MixpanelEventService.instance.track(
  //       AppMixpanelEvents.sendValidationPurchaseOnBackendError,
  //       parameters: {AnalyticsParameters.errorMessage: error.message},
  //     );
  //     add(SubscriptionV2Event.errorPurchase(error));
  //   }, (r) async {
  //     if (r.isActive) {
  //       await _purchasedSuccess(purchaseDetails, r);
  //     } else if (!r.isActive && isRestore) {
  //       add(
  //         const SubscriptionV2Event.errorPurchase(
  //           RequestError.streamSubscription(
  //             ServerErrorData(message: LocalizedTexts.subscriptionEmptyToRestore),
  //           ),
  //         ),
  //       );
  //     } else {
  //       add(SubscriptionV2Event.notifySubscriptionExpired(subscription: r));
  //     }
  //   });
  // }
  //
  // Future<void> _purchasedSuccess(PurchaseDetails purchaseDetails, Subscription r) async {
  //   MixpanelEventService.instance.track(
  //     AppMixpanelEvents.userPurchasedSubscription,
  //     parameters: {
  //       AnalyticsParameters.productIdentifier: purchaseDetails.productID,
  //       AnalyticsParameters.purchaseIdentifier: purchaseDetails.purchaseID,
  //       AnalyticsParameters.purchaseStatus: purchaseDetails.status.name,
  //       AnalyticsParameters.transactionDate: DateTime.fromMillisecondsSinceEpoch(int.parse(purchaseDetails.transactionDate!) * 1000),
  //     },
  //   );
  //   MixpanelEventService.instance.track(AppMixpanelEvents.sendValidationPurchaseOnBackendSuccess);
  //   final accessTokenUpdated = await _authTokenManager.updateAccessToken();
  //   if (accessTokenUpdated) {
  //     _pushAnalyticBoughtEvent(purchaseDetails, r);
  //     add(
  //       SubscriptionV2Event.purchasedSubscription(
  //         r,
  //         PurchasedProductV2(
  //           purchaseDetails: purchaseDetails,
  //           memberSince: SubscriptionDateUtils.getTransactionDate(r.purchasedAt),
  //         ),
  //       ),
  //     );
  //   } else {
  //     MixpanelEventService.instance.track(AppMixpanelEvents.getAccessTokenWithSubscriptionError);
  //     add(
  //       const SubscriptionV2Event.errorPurchase(
  //         RequestError.streamSubscription(
  //           ServerErrorData(message: LocalizedTexts.errorPurchaseVerificationError),
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  // Future<Either<RequestError, Subscription>> _apiPurchaseOrRestore(PurchaseDetails purchaseDetails) async {
  //   var isIOS = purchaseDetails is AppStorePurchaseDetails;
  //
  //   final identifier = _getTransactionId(purchaseDetails) ?? '';
  //   MixpanelEventService.instance.track(
  //     AppMixpanelEvents.sendValidationPurchaseOnBackend,
  //     parameters: {
  //       AnalyticsParameters.productIdentifier: purchaseDetails.productID,
  //       AnalyticsParameters.purchaseIdentifier: purchaseDetails.purchaseID,
  //       AnalyticsParameters.purchaseStatus: purchaseDetails.status.name,
  //       if (purchaseDetails.transactionDate != null)
  //         AnalyticsParameters.transactionDate: DateTime.fromMillisecondsSinceEpoch(int.parse(purchaseDetails.transactionDate!) * 1000),
  //     },
  //   );
  //   var response = isIOS
  //       ? await _purchaseService.purchaseIOS(
  //           VerifyIOSPurchaseData(receipt: purchaseDetails.verificationData.serverVerificationData, transactionId: identifier), vendor)
  //       : await _purchaseService.purchaseAndroid(
  //           VerifyAndroidPurchaseData(receipt: purchaseDetails.verificationData.serverVerificationData, purchaseToken: identifier), vendor);
  //   return response;
  // }
  //
  // void _pushAnalyticErrorVerifyOnServer(PurchaseDetails purchaseDetails) {
  //   usageAnalytics.track(
  //     eventName: AnalyticsEvents.subscriptionErrorVerifyOnServer,
  //     attributes: {
  //       UsageAnalyticsAttributes.identifierOption: purchaseDetails.productID,
  //     },
  //   );
  //   const AnalyticsEventService.uxcam().logEvent(
  //     eventName: AnalyticsEvents.subscriptionErrorVerifyOnServer,
  //     parameters: {
  //       AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
  //       AnalyticsParameters.productIdentifier: purchaseDetails.productID,
  //     },
  //   );
  // }
  //
  // void _pushAnalyticBoughtEvent(PurchaseDetails purchaseDetails, Subscription r) {
  //   usageAnalytics.track(
  //     eventName: UsageAnalyticsEvents.subscriptionBought,
  //     attributes: {
  //       UsageAnalyticsAttributes.identifierOption: purchaseDetails.productID,
  //       UsageAnalyticsAttributes.subscriptionExpirationDate: r.expiresAt,
  //     },
  //   );
  // }
  //
  // String? _getTransactionId(PurchaseDetails purchaseDetails) {
  //   if (purchaseDetails is AppStorePurchaseDetails) {
  //     return purchaseDetails.skPaymentTransaction.transactionIdentifier;
  //   } else if (purchaseDetails is GooglePlayPurchaseDetails) {
  //     return purchaseDetails.billingClientPurchase.purchaseToken;
  //   } else {
  //     return null;
  //   }
  // }
  //
  // List<ProductDetails> _getUniqueAndroidPlans(List<ProductDetails> plans) {
  //   if (plans.isEmpty) {
  //     return [];
  //   }
  //   final map = plans.groupBy((plan) => plan.id);
  //
  //   List<ProductDetails> list =
  //       map.entries.map((list) => list.value.reduce((curr, next) => curr.rawPrice.toInt() < next.rawPrice.toInt() ? next : curr)).toList();
  //   List<ProductDetails> orderList = [];
  //
  //   for (var plan in list) {
  //     if (state.data.serverPlans.any((serverPlan) => serverPlan.productId == plan.id)) {
  //       orderList.add(plan);
  //     }
  //   }
  //   return orderList;
  // }
  //
  // List<ProductDetails> _getIosPlans(List<ProductDetails> plans) {
  //   if (plans.isEmpty) {
  //     return [];
  //   }
  //   List<ProductDetails> list = [...plans];
  //   list.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
  //   return list;
  // }
}
