// ignore_for_file: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/domain/purchasable_product.dart';
import 'package:loopcare_frontend/features/subscription/domain/sku_product.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

//import for SKProductWrapper
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';

class SubscriptionController {
  final SubscriptionBloc bloc;
  SubscriptionStateData data = const SubscriptionStateData();
  ValueNotifier<bool> isEnableSubscribe = ValueNotifier(false);
  ValueNotifier<String> subscribeTitle = ValueNotifier(LocalizedTexts.subscriptionSubscribe.tr());
  final ValueNotifier<bool> sheetOpenedNotifier = ValueNotifier(false);
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<PurchasableProduct?> selectedPlan = ValueNotifier(null);
  List<PurchasableProduct> products = [];

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
        if (data.plans.length == 1) {
          subscribeTitle.value = product.description;
          selectedPlan.value = products.first;
          isEnableSubscribe.value = true;
        }

      }
    }
  }

  SkuProduct _getProductDetailsFromStore(ProductDetails product) {
    if (product is AppStoreProductDetails) {
      SKProductWrapper skProduct = product.skProduct;
      final offerPriceAmount = int.parse(skProduct.introductoryPrice?.price ?? '0');
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
          offerPriceAmount: phase.priceAmountMicros,
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
    CustomerIoService.track(
      event: CIOEvents.subscriptionSelected,
      attributes: {
        CIOAttributes.identifierOption: plan.details.id,
      },
    );
  }

  void resetState() {
    selectedPlan.value = null;
    isEnableSubscribe.value = false;
    loading.value = false;
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

  void restorePurchase() => bloc.add(const SubscriptionEvent.restorePurchased());

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
