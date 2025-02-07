// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/injection.dart';

@injectable
class AppSubscriptionService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final Stream<List<PurchaseDetails>> storeSubscription = InAppPurchase.instance.purchaseStream;
  final usageAnalytics = UsageAnalytics();

  String? get customerIOId => getIt<SharedStorageService>().account?.customerIoId;

  InAppPurchase get instance => _inAppPurchase;
  final List purchasedList = [];

  Future<List<ProductDetails>> getSubscriptionPlans(Set<String> main) async {
    final Set<String> main = {
      'monthly',
      'quarterly',
      "annual",
      "NY_2025_15",
      "ny_2025_15",
      "monthly99q12025"
    };
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      _pushAnalyticServiceUnAvailable();

      return [];
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(main);

    if (productDetailResponse.error != null) {
      return [];
    }

    if (productDetailResponse.productDetails.isEmpty) {
      return [];
    }

    return productDetailResponse.productDetails;
  }

  Future<bool> buyItemInStore(ProductDetails product) async {
    if (Platform.isIOS) {
      await finishTransactionIOS();
    }
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: product, applicationUserName: customerIOId);
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      _pushAnalyticServiceUnAvailable(productId: product.id);
      return false;
    }
    final isBought = await instance.buyNonConsumable(purchaseParam: purchaseParam);
    return isBought;
  }

  Future<void> finishTransactionIOS() async {
    final paymentWrapper = SKPaymentQueueWrapper();
    final transactions = await paymentWrapper.transactions();
    await Future.wait(
        transactions.map((transaction) => paymentWrapper.finishTransaction(transaction)));
  }

  Future<void> completePurchase(PurchaseDetails? purchaseDetails) async {
    if (purchaseDetails != null &&
        (purchaseDetails.pendingCompletePurchase ||
            purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored)) {
      try {
        await instance.completePurchase(purchaseDetails);
      } catch (e) {
        log.e(
          e.toString(),
          error: e.runtimeType,
        );
        return;
      }
    }
    return;
  }

  Future<void> restorePurchase() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      _pushAnalyticServiceUnAvailable();
      return;
    }
    await instance.restorePurchases();
  }

  void _pushAnalyticServiceUnAvailable({String? productId}) {
    usageAnalytics.track(
      eventName: AnalyticsEvents.subscriptionServiceUnavailable,
    );
    const AnalyticsEventService.uxcam().logEvent(
      eventName: AnalyticsEvents.subscriptionServiceUnavailable,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
        if (productId != null) AnalyticsParameters.productIdentifier: productId,
      },
    );
    MixpanelEventService.instance.track(
      AppMixpanelEvents.subscriptionPurchaseError,
      parameters: {
        if (productId != null) AnalyticsParameters.productIdentifier: productId,
        AnalyticsParameters.errorMessage: 'subscription_service_unavailable',
      },
    );
  }
}
