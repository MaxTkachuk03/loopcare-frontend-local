import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_details_subscriptions.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '../../../injection.dart';

part 'subscription_event.dart';

part 'subscription_state.dart';

part 'subscription_bloc.freezed.dart';

@singleton
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  late PurchaseDetailsStreamSubscription purchaseDetailsStreamSubscription;
  final inAppPurchaseService = getIt<AppSubscriptionService>();

  SubscriptionBloc() : super(const SubscriptionState.initial(SubscriptionStateData())) {
    on<SubscriptionInit>(_onInitSubscription);
    on<SubscriptionDispose>(_onSubscriptionDispose);
    on<BuySubscription>(_onBuySubscription);
    on<PurchasedSubscription>(_onPurchasedSubscription);
    on<GetStatusSubscription>(_onGetStatusSubscription);
    on<GetSubscriptionPlans>(_onGetSubscriptionPlans);
    purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscription(
      onCanceled: () => debugPrint('devcpp Subscription Canceled'),
      onError: () => debugPrint('devcpp Subscription Error '),
      onPurchased: (PurchaseDetails purchaseDetails) async {
        debugPrint('devcpp  onPurchased: ${purchaseDetails.toString()}');
        debugPrint('devcpp  purchase ID: ${purchaseDetails.purchaseID}');
        debugPrint(
            'devcpp  purchase serverVerificationData: ${purchaseDetails.verificationData.serverVerificationData}');
        debugPrint('devcpp  purchase localVerificationData: ${purchaseDetails.verificationData.localVerificationData}');
        _handlePurchase(purchaseDetails);
      },
    )..init();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    try {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // Send to server
        // var validPurchase = await _verifyPurchase(purchaseDetails);
      }
      // if (res) {
      if (purchaseDetails.pendingCompletePurchase) {
        await inAppPurchaseService.instance.completePurchase(purchaseDetails);
        add(const SubscriptionEvent.purchasedSubscription());
      }
      // }
    } catch (_, __) {}
  }

  FutureOr<void> _onInitSubscription(
    SubscriptionInit event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionState.initial(SubscriptionStateData()));
  }

  FutureOr<void> _onGetSubscriptionPlans(
    GetSubscriptionPlans event,
    Emitter<SubscriptionState> emit,
  ) async {
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    final plans = await inAppPurchaseService.getSubscriptionPlans();
    emit(
      SubscriptionState.successInPlans(SubscriptionStateData(plans: plans)),
    );
    add(const SubscriptionEvent.getStatusSubscription());
  }

  FutureOr<void> _onPurchasedSubscription(
    PurchasedSubscription event,
    Emitter<SubscriptionState> emit,
  ) async =>
      emit(SubscriptionState.purchasedSubscription(state.data));

  FutureOr<void> _onGetStatusSubscription(
    GetStatusSubscription event,
    Emitter<SubscriptionState> emit,
  ) async =>
      emit(SubscriptionState.trial(state.data));

  FutureOr<void> _onBuySubscription(
    BuySubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    debugPrint('devcpp Buy request: ${event.product.id}');
    final response = await inAppPurchaseService.buyItemInStore(event.product);
    debugPrint('devcpp Buy response: ${response.toString()}');
  }

  FutureOr<void> _onSubscriptionDispose(
    SubscriptionDispose event,
    Emitter<SubscriptionState> emit,
  ) {
    purchaseDetailsStreamSubscription.close();
  }
}
