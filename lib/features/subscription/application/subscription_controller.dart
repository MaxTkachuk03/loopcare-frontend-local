import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/donain/purchasable_product.dart';

class SubscriptionController {
  final SubscriptionBloc bloc;
  SubscriptionStateData data = const SubscriptionStateData();
  ValueNotifier<bool> isEnableSubscribe = ValueNotifier(false);
  ValueNotifier<PurchasableProduct?> selectedPlan = ValueNotifier(null);
  PurchasableProduct annual = const PurchasableProduct(monthlyPrice: 2, commonPrice: 24, currency: '', isAnnual: true);
  PurchasableProduct monthly = const PurchasableProduct(monthlyPrice: 1, commonPrice: 1, currency: '');

  SubscriptionController({required this.bloc});

  void _setupPlansPrices() {
    if (data.plans.isEmpty) {
      return;
    }

    for (var plan in data.plans) {
      debugPrint('devcpp  PLAN ID:  ${plan.id}  PRICE: ${plan.rawPrice} CURRENCY:  ${plan.currencySymbol}');
      if (plan.id == 'annual') {
        annual = PurchasableProduct(
          details: plan,
          monthlyPrice: _getPricePerMonth(plan.rawPrice),
          commonPrice: plan.rawPrice,
          currency: plan.currencySymbol,
          isAnnual: true,
        );
      } else {
        monthly = PurchasableProduct(
            details: plan,
            monthlyPrice: plan.rawPrice,
            commonPrice: plan.rawPrice,
            currency: plan.currencySymbol);
      }
    }
  }

  String _getCurrency(String currencyCode) => NumberFormat().simpleCurrencySymbol(currencyCode);

  void setupPlans(SubscriptionStateData stateData) {
    data = stateData;
    _setupPlansPrices();
  }

  void setPlans(PurchasableProduct plan) {
    selectedPlan.value = plan;
    isEnableSubscribe.value = true;
  }

  double _getPricePerMonth(double annualPrice) => annualPrice / 12;

  void onSubscribe() {
    if (selectedPlan.value?.details == null) {
      return;
    }
    bloc.add(SubscriptionEvent.buySubscription(selectedPlan.value!.details!));
  }
  void restorePurchase() => bloc.add(const SubscriptionEvent.restorePurchased());

  void getSubscriptionPlans() => bloc.add(const SubscriptionEvent.getSubscriptionPlans());

  void getActiveSubscriptionStatus() => bloc.add(const SubscriptionEvent.getActiveSubscription());

  void dispose() => bloc.add(const SubscriptionEvent.dispose());
}
