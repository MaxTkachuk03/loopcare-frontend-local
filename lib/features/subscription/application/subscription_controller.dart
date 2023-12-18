import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/donain/purchasable_product.dart';

class SubscriptionController {
  final SubscriptionBloc bloc;
  SubscriptionStateData data = const SubscriptionStateData();
  ValueNotifier<bool> isEnableSubscribe = ValueNotifier(false);
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<PurchasableProduct?> selectedPlan = ValueNotifier(null);
  List<PurchasableProduct> products = [];

  SubscriptionController({required this.bloc});

  void _setupPlansPrices() {
    if (data.plans.isEmpty) {
      return;
    }
    for (var plan in data.plans) {
      if (Platform.isAndroid) {}
      products.add(PurchasableProduct(
        details: plan,
        offer: _getPricePerMonth(plan.rawPrice),
        regularPrice: plan.rawPrice,
        currency: plan.currencySymbol,
      ));
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

  void resetState() {
    selectedPlan.value = null;
    isEnableSubscribe.value = false;
    loading.value = false;
  }

  double _getPricePerMonth(double annualPrice) => _roundNumber(annualPrice / 12, 2);

  double _roundNumber(double value, int places) {
    num val = pow(10.0, places);
    return ((value * val).round().toDouble() / val);
  }

  void handleLoading(bool isLoading) {
    isEnableSubscribe.value = !isLoading && (selectedPlan.value != null);
    loading.value = isLoading;
  }

  void onSubscribe() {
    if (selectedPlan.value?.details == null) {
      return;
    }
    bloc.add(SubscriptionEvent.verifyLastPurchase(selectedPlan.value!.details!));
  }

  void restorePurchase() => bloc.add(const SubscriptionEvent.restorePurchased());

  void getSubscriptionPlans() => bloc.add(const SubscriptionEvent.getPlansFromServer());

  void getActiveSubscriptionStatus() => bloc.add(const SubscriptionEvent.getActiveSubscription());

  void dispose() {
    isEnableSubscribe.dispose();
    loading.dispose();
    selectedPlan.dispose();
    bloc.add(const SubscriptionEvent.dispose());
  }
}
