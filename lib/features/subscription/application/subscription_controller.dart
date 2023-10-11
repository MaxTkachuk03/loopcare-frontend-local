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
    }
    annual = PurchasableProduct(
      details: data.plans[1],
      monthlyPrice: _getPricePerMonth(data.plans[1].rawPrice).toInt(),
      commonPrice: data.plans[1].rawPrice.toInt(),
      currency: data.plans[1].currencySymbol,
      isAnnual: true,
    );
    monthly = PurchasableProduct(
        details: data.plans[0],
        monthlyPrice: data.plans[0].rawPrice.toInt(),
        commonPrice: data.plans[0].rawPrice.toInt(),
        currency: data.plans[0].currencySymbol);
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

  int _getPricePerMonth(double annualPrice) => annualPrice ~/ 12;

  void onSubscribe() {
    if (selectedPlan.value?.details == null) {
      return;
    }
    bloc.add(SubscriptionEvent.buySubscription(selectedPlan.value!.details!));
  }

  void getPlans() => bloc.add(const SubscriptionEvent.getSubscriptionPlans());
  void getPlansState() => bloc.add(const SubscriptionEvent.getStatusSubscription());

  void dispose() => bloc.add(const SubscriptionEvent.dispose());
}
