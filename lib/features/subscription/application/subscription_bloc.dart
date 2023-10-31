import 'dart:async';

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/account/subscription.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_details_subscriptions.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_service.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:loopcare_frontend/features/subscription/donain/purchased_product.dart';
import 'package:loopcare_frontend/features/subscription/donain/subscription_state.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data.dart';
import 'package:loopcare_frontend/features/subscription/utils/date_utils.dart';

import '../../../injection.dart';

part 'subscription_event.dart';

part 'subscription_state.dart';

part 'subscription_bloc.freezed.dart';

@singleton
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  late PurchaseDetailsStreamSubscription purchaseDetailsStreamSubscription;
  final inAppPurchaseService = getIt<AppSubscriptionService>();
  final AuthenticationService _authenticationService;
  final PurchaseService _purchaseService;

  SubscriptionBloc(this._authenticationService, this._purchaseService)
      : super(const SubscriptionState.initial(SubscriptionStateData())) {
    on<SubscriptionInit>(_onInitSubscription);
    on<SubscriptionDispose>(_onSubscriptionDispose);
    on<BuySubscription>(_onBuySubscription);
    on<RestorePurchased>(_onRestorePurchased);
    on<PurchasedSubscription>(_onPurchasedSubscription);
    on<ErrorVerifyPurchase>(_onErrorVerifyPurchase);
    on<GetActiveSubscription>(_onGetActiveSubscription);
    on<GetSubscriptionPlans>(_onGetSubscriptionPlans);
    purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscription(
      onCanceled: () => debugPrint('devcpp Subscription Canceled'),
      onError: (error) => add(SubscriptionEvent.errorVerifyPurchase(error)),
      onRestored: (purchase) async => _restoreTransactionData(purchase),
      onPurchased: (PurchaseDetails purchaseDetails) async => _handlePurchase(purchaseDetails),
    )..init();
  }

  void _restoreTransactionData(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.restored) {
      // Send to server
      await _verifyPurchase(purchaseDetails);
    }
  }

  String? _getTransactionId(PurchaseDetails purchaseDetails) {
    if (purchaseDetails is AppStorePurchaseDetails) {
      final transactionIdentifier = purchaseDetails.skPaymentTransaction.transactionIdentifier;
        final purchaseID = transactionIdentifier;
        debugPrint('devcpp  status: iOS transactionIdentifier -> ${purchaseDetails.productID} -> $purchaseID');
        return purchaseID;

    } else if (purchaseDetails is GooglePlayPurchaseDetails) {
      final originalBilling = purchaseDetails.billingClientPurchase;
      debugPrint(
          'devcpp  status: Google   purchaseToken & orderId -> ${originalBilling.purchaseToken} -> ${originalBilling.orderId}');
      return originalBilling.purchaseToken;
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    try {
      if (purchaseDetails.pendingCompletePurchase) {
        debugPrint('devcpp  CompletePurchase product ID: ${purchaseDetails.productID}');
        await inAppPurchaseService.instance.completePurchase(purchaseDetails);
      }

      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // Send to server
        await _verifyPurchase(purchaseDetails);
      }
    } catch (_, __) {}
  }

  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    final vendor = purchaseDetails is AppStorePurchaseDetails ? 'ios' : 'android';
    log('devcpp  purchase serverVerificationData: ${purchaseDetails.verificationData.serverVerificationData}');
    log('devcpp  purchase localVerificationData: ${purchaseDetails.verificationData.localVerificationData}');
   final identifier =  _getTransactionId(purchaseDetails) ?? '';
    debugPrint('devcpp TransactionId: $identifier');
    var response = await _purchaseService.verifyPurchase(
        VerifyPurchaseData(receipt: purchaseDetails.verificationData.serverVerificationData, transactionId:identifier), vendor);
    response.fold((error) {
      debugPrint('devcpp error VerifyPurchaseData: $error');
      add(SubscriptionEvent.errorVerifyPurchase(error));
    }, (r) async {
      await inAppPurchaseService.instance.completePurchase(purchaseDetails);
      add(SubscriptionEvent.purchasedSubscription(PurchasedProduct(
        purchaseDetails: purchaseDetails,
        memberSince: SubscriptionDateUtils.getTransactionDate(r.purchasedAt),
      )));
    });
  }

  FutureOr<void> _onPurchasedSubscription(
    PurchasedSubscription event,
    Emitter<SubscriptionState> emit,
  ) async =>
      emit(SubscriptionState.purchasedSubscription(state.data.copyWith(
        purchased: event.purchasedProduct,
        isLoading: false,
      )));

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
    debugPrint('devcpp  _onRestorePurchased');
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    inAppPurchaseService.restorePurchase();
  }

  FutureOr<void> _onGetSubscriptionPlans(
    GetSubscriptionPlans event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    final plans = await inAppPurchaseService.getSubscriptionPlans();

    emit(
      SubscriptionState.successInPlans(state.data.copyWith(isLoading: false, plans: plans)),
    );
  }

  FutureOr<void> _onGetActiveSubscription(
    GetActiveSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    debugPrint('devcpp fetchAccount');
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
        final status =
            subscription == null ? SubscriptionStatus.trialPeriod : SubscriptionStatusUtil.parse(subscription!.state);
        emit(
          SubscriptionState.loading(state.data.copyWith(isLoading: false)),
        );
        debugPrint('devcpp SubscriptionStatus: ${subscription?.state}');
        switch (status) {
          case SubscriptionStatus.trialPeriod:
            emit(SubscriptionState.trial(state.data.copyWith(subscription: subscription)));
            break;
          case SubscriptionStatus.common:
            if (subscription != null &&
                !subscription.isActive &&
                SubscriptionDateUtils.isPassDate(subscription.expiresAt)) {
              emit(SubscriptionState.subscriptionEnded(state.data.copyWith(subscription: subscription)));
            } else if (subscription?.isActive??false){
              emit(SubscriptionState.subscriptionActive(state.data.copyWith(subscription: subscription)));
            } else{
              emit(SubscriptionState.trialExpired(state.data.copyWith(subscription: subscription)));
            }
            break;

          case SubscriptionStatus.cancelled:
            emit(SubscriptionState.subscriptionCancelled(state.data.copyWith(subscription: subscription)));
            break;
          case SubscriptionStatus.gracePeriod:
            emit(SubscriptionState.subscriptionUnRenewed(state.data.copyWith(subscription: subscription)));
            break;
          default:
            emit(SubscriptionState.subscriptionActive(state.data.copyWith(subscription: subscription)));
        }
      },
    );
  }

  FutureOr<void> _onBuySubscription(
    BuySubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    debugPrint('devcpp Buy request: ${event.product.id}');
    final response = await inAppPurchaseService.buyItemInStore(event.product);
    debugPrint('devcpp Buy response: ${response.toString()}');
    // emit(
    //   SubscriptionState.loading(state.data.copyWith(isLoading: false)),
    // );
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
}
