import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/domain/purchasable_product.dart';
import 'package:loopcare_frontend/features/subscription/utils/mapper_utils.dart';

class SubscriptionController {
  final SubscriptionBloc bloc;
  SubscriptionStateData data = const SubscriptionStateData();
  ValueNotifier<bool> isEnableSubscribe = ValueNotifier(false);
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<PurchasableProduct?> selectedPlan = ValueNotifier(null);
  List<PurchasableProduct> products = [];

  SubscriptionController({required this.bloc});

  List<ProductDetails> _getUniqueAndroidPlans() {
    if (data.plans.isEmpty) {
      return [];
    }
    final map = data.plans.groupBy((plan) => plan.id);

    List<ProductDetails> list = map.entries
        .map((list) => list.value
            .reduce((curr, next) => curr.rawPrice.toInt() < next.rawPrice.toInt() ? curr : next))
        .toList();
    List<ProductDetails> orderList = [];
    for (var serverPlan in data.serverPlans) {
      for (var plan in list) {
        if (serverPlan.productId == plan.id) {
          orderList.add(plan);
        }
      }
    }
    return orderList;
  }

  List<ProductDetails> _getIosPlans() {
    if (data.plans.isEmpty) {
      return [];
    }
    List<ProductDetails> list = [...data.plans];
    list.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
    return list;
  }

  void _setupPlansPrices() {
    if (data.plans.isEmpty) {
      return;
    }
    List<ProductDetails> list = [
      ...(Platform.isAndroid ? _getUniqueAndroidPlans() : _getIosPlans())
    ];
    final lastId = list.isNotEmpty ? list.last.id : -1;

    for (var serverPlan in data.serverPlans) {
      for (var plan in list) {
        if (serverPlan.productId == plan.id) {
          products.add(PurchasableProduct(
              details: plan,
              offer: _getPricePerMonth(plan.rawPrice),
              regularPrice: plan.rawPrice,
              currency: _getCurrency(plan.currencyCode),
              recommended: plan.id == lastId,
              localizationDescription: serverPlan.subscriptionPlan?.description,
              localizationTitle: serverPlan.subscriptionPlan?.title));
        }
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
    CustomerIoService.track(
      event: CIOEvents.subscriptionSelected,
      attributes: {
        CIOAttributes.identifierOption: plan.details?.id,
      },
    );
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
