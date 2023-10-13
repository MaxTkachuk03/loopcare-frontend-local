import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/account/subscription.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_details_subscriptions.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:loopcare_frontend/features/subscription/donain/purchased_product.dart';
import 'package:loopcare_frontend/features/subscription/donain/subscription_state.dart';

import '../../../injection.dart';

part 'subscription_event.dart';

part 'subscription_state.dart';

part 'subscription_bloc.freezed.dart';

@singleton
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  late PurchaseDetailsStreamSubscription purchaseDetailsStreamSubscription;
  final inAppPurchaseService = getIt<AppSubscriptionService>();
  final AuthenticationService _authenticationService;

  SubscriptionBloc(this._authenticationService) : super(const SubscriptionState.initial(SubscriptionStateData())) {
    on<SubscriptionInit>(_onInitSubscription);
    on<SubscriptionDispose>(_onSubscriptionDispose);
    on<BuySubscription>(_onBuySubscription);
    on<PurchasedSubscription>(_onPurchasedSubscription);
    on<GetActiveSubscription>(_onGetActiveSubscription);
    on<GetSubscriptionPlans>(_onGetSubscriptionPlans);
    purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscription(
      onCanceled: () => debugPrint('devcpp Subscription Canceled'),
      onError: () => debugPrint('devcpp Subscription Error '),
      onPurchased: (PurchaseDetails purchaseDetails) async {
        debugPrint('devcpp  product ID: ${purchaseDetails.productID}');
        debugPrint(
            'devcpp  purchase serverVerificationData: ${purchaseDetails.verificationData.serverVerificationData}');
        debugPrint('devcpp  purchase localVerificationData: ${purchaseDetails.verificationData.localVerificationData}');
        _handlePurchase(purchaseDetails);
      },
    )..init();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    try {
      if (purchaseDetails.pendingCompletePurchase) {
        await inAppPurchaseService.instance.completePurchase(purchaseDetails);
      }
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // Send to server
        // var validPurchase = await _verifyPurchase(purchaseDetails);

        // if (res) {

        DateTime date = DateTime.fromMillisecondsSinceEpoch(
          int.parse(purchaseDetails.transactionDate!),
        );
        String transactionDate = DateFormat('dd MMM yyyy').format(date);
        debugPrint('devcpp  transactionDate: $transactionDate');
        add(SubscriptionEvent.purchasedSubscription(PurchasedProduct(
          purchaseDetails: purchaseDetails,
          memberSince: transactionDate,
        )));
      }
      // }
    } catch (_, __) {}
  }

  FutureOr<void> _onPurchasedSubscription(
    PurchasedSubscription event,
    Emitter<SubscriptionState> emit,
  ) async =>
      emit(SubscriptionState.purchasedSubscription(state.data.copyWith(purchased: event.purchasedProduct)));

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
    add(const SubscriptionEvent.getActiveSubscription());
  }

  FutureOr<void> _onGetActiveSubscription(
    GetActiveSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    debugPrint('devcpp fetchAccount');
    final response = await _authenticationService.fetchAccount();
    //Todo Subscription

    response.fold(
      (error) {
        debugPrint('devcpp error Account: $error');
        emit(SubscriptionState.error(state.data.copyWith(error: error)));
      },
      (r) {
        // Todo final status = SubscriptionStatusUtil.parse(r.subscription.state);
        var subscription = const Subscription();
        final status = subscription == null ? SubscriptionStatus.trialPeriod:SubscriptionStatusUtil.parse(subscription.state);

        debugPrint('devcpp SubscriptionStatus: ${status.name}');
        switch (status) {
          case SubscriptionStatus.trialPeriod:
            emit(SubscriptionState.trial(state.data.copyWith(subscription: subscription)));
            break;
          case SubscriptionStatus.common:
            if (!subscription.isActive && _isPassDate(subscription.expiresAt)) {
              emit(SubscriptionState.subscriptionEnded(state.data.copyWith(subscription: subscription)));
            } else {
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
            emit(SubscriptionState.subscriptionActual(state.data.copyWith(subscription: subscription)));
        }
      },
    );
  }

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

  bool _isPassDate(String? timeStamp) {
    if (timeStamp == null) {
      return true;
    }

    final date = DateFormat('yyyy-MM-ddTHH:mm:sssZ').parseUtc(timeStamp).toLocal();
    return date.isAfter(DateTime.now()) || date.isSameDate(DateTime.now());
  }
}
