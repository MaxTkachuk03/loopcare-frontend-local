// ignore_for_file: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/events.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/mixpanel_event_service.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/domain/purchasable_product.dart';
import 'package:loopcare_frontend/features/subscription/domain/sku_product.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SubscriptionController {
  final SubscriptionBloc bloc;
  SubscriptionStateData data = const SubscriptionStateData();
  ValueNotifier<bool> isEnableSubscribe = ValueNotifier(false);
  ValueNotifier<String> subscribeTitle = ValueNotifier(LocalizedTexts.subscriptionSubscribe.tr());
  final ValueNotifier<bool> sheetOpenedNotifier = ValueNotifier(false);
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<PurchasableProduct?> selectedPlan = ValueNotifier(null);
  List<PurchasableProduct> products = [];
  final usageAnalytics = UsageAnalytics();
  SubscriptionController({required this.bloc});

  void _setupPlansPrices() {
    if (data.plans.isEmpty) {
      return;
    }

    for (var plan in data.plans) {
      final serverPlan =
          data.serverPlans.firstWhereOrNull((serverPlan) => serverPlan.productId == plan.id);
      if (serverPlan != null) {
        final SkuProduct skuProduct = _getProductDetailsFromStore(plan);
        var product = PurchasableProduct(
          details: plan,
          skuProduct: skuProduct,
          showBadge: false,
          subscriptionTranslation: serverPlan.subscriptionTranslation,
          carouselImages: serverPlan.carouselImages,
          isOfferEligible: data.isEligible,
        );
        products.add(product);
      }
    }
    if (products.isNotEmpty) {
      subscribeTitle.value = products.first.description;
      selectedPlan.value = products.first;
      isEnableSubscribe.value = true;
    }

    String selectedPlanDetails = selectedPlan.value == null
        ? "N/A"
        : "${selectedPlan.value?.details.id ?? 'No ID'} -> ${selectedPlan.value?.skuProduct.offerId ?? 'No Offer ID'}";

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.subscriptionsFromStore,
      attributes: {
        "product_ids": products.map((product) => product.details.id).toString(),
        "product_price": products.map((product) => product.skuProduct.regularPrice).toString(),
        "offer_ids": products.map((product) => product.skuProduct.offerId).toString(),
        "offer_eligible": products.map((product) => product.isOfferEligible).toString(),
        "offer_price": products.map((product) => product.skuProduct.offerPriceAmount).toString(),
        "displayed_plan": selectedPlanDetails,
      },
    );

    MixpanelEventService.instance.track(
      AppMixpanelEvents.getUserAvailableProductsOffers,
      parameters: {
        AnalyticsParameters.purchaseProductIds:
            products.map((product) => product.details.id).toString(),
        AnalyticsParameters.productOfferID:
            products.map((product) => product.skuProduct.offerId).toString(),
        AnalyticsParameters.productOfferPrice:
            products.map((product) => product.skuProduct.offerPriceAmount).toString(),
      },
    );
  }

  SkuProduct _getProductDetailsFromStore(ProductDetails product) {
    if (product is AppStoreProductDetails) {
      SKProductWrapper skProduct = product.skProduct;
      final offerPriceAmount = double.parse(skProduct.introductoryPrice?.price ?? '0');
      return SkuProduct(
        unitOffer: getIosUnit(skProduct.introductoryPrice?.subscriptionPeriod.unit.name),
        unitOfferCount: skProduct.introductoryPrice?.subscriptionPeriod.numberOfUnits ?? 0,
        offerPrice: skProduct.introductoryPrice?.price,
        offerPriceAmount: offerPriceAmount,
        offerId: skProduct.introductoryPrice?.identifier,
        regularPrice: product.rawPrice,
      );
    }

    final skuDetails = (product as GooglePlayProductDetails).productDetails;

    List<SubscriptionOfferDetailsWrapper>? subscriptionOfferDetails =
        skuDetails.subscriptionOfferDetails;
    if (subscriptionOfferDetails == null) {
      return SkuProduct(
        regularPrice: product.rawPrice,
        offerPrice: null,
        unitOfferCount: 0,
        unitOffer: Unit.month,
      );
    }

    for (var detail in subscriptionOfferDetails) {
      var pricingPhases = detail.pricingPhases;
      for (var phase in pricingPhases) {
        final unitCount = getAndroidCountUnit(phase.billingPeriod);
        final unit = getAndroidUnit(phase.billingPeriod);
        final offerPrice = phase.formattedPrice;
        return SkuProduct(
          regularPrice: product.rawPrice,
          offerPrice: detail.offerId != null ? offerPrice : null,
          offerPriceAmount: phase.priceAmountMicros.toDouble(),
          offerId: detail.offerId,
          unitOfferCount: unitCount,
          unitOffer: unit,
        );
      }
    }

    return SkuProduct(
      regularPrice: product.rawPrice,
      offerPrice: null,
      unitOfferCount: 0,
      unitOffer: Unit.month,
    );
  }

  void setupPlans(SubscriptionStateData stateData) {
    data = stateData;
    _setupPlansPrices();
  }

  void setPlans(PurchasableProduct plan) {
    selectedPlan.value = plan;
    isEnableSubscribe.value = true;
    _pushAnalyticsEvents(plan);
  }

  void _pushAnalyticsEvents(PurchasableProduct plan) {
    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.subscriptionSelected,
      attributes: {
        UsageAnalyticsAttributes.identifierOption: plan.details.id,
      },
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: UsageAnalyticsEvents.subscriptionSelected,
      parameters: {
        AnalyticsParameters.productIdentifier: plan.details.id,
      },
    );
  }

  void handleLoading(bool isLoading) {
    isEnableSubscribe.value = !isLoading && (selectedPlan.value != null);
    loading.value = isLoading;
  }

  void onSubscribe() {
    if (selectedPlan.value?.details == null) {
      return;
    }
    bloc.add(SubscriptionEvent.verifyLastPurchase(selectedPlan.value!.details));
  }

  void restorePurchase() {
    bloc.add(const SubscriptionEvent.restorePurchased());
  }

  void getSubscriptionPlansFromServer() => bloc.add(const SubscriptionEvent.getPlansFromServer());

  void getActiveSubscriptionStatus() => bloc.add(const SubscriptionEvent.getActiveSubscription());

  void checkSubscriptionEligible() => bloc.add(const SubscriptionEvent.checkEligibility());

  void processingDataPlans() => bloc.add(const SubscriptionEvent.processingDataPlans());

  void dispose() {
    isEnableSubscribe.dispose();
    loading.dispose();
    selectedPlan.dispose();
    subscribeTitle.dispose();
    sheetOpenedNotifier.dispose();
    bloc.add(const SubscriptionEvent.dispose());
  }
}
