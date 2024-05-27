import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/injection.dart';

@injectable
class AppSubscriptionService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final Stream<List<PurchaseDetails>> storeSubscription = InAppPurchase.instance.purchaseStream;

  String? get customerIOId => getIt<SharedStorageService>().account?.customerIoId;

  InAppPurchase get instance => _inAppPurchase;
  final List purchasedList = [];

  Future<List<ProductDetails>> getSubscriptionPlans(Set<String> main) async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      return [];
    }
    final ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(main);

    if (productDetailResponse.error != null || productDetailResponse.productDetails.isEmpty) {
      return [];
    }
    return productDetailResponse.productDetails;
  }

  Future<bool> buyItemInStore(ProductDetails product) async {
    if (Platform.isIOS) {
      await finishTransactionIOS();
    }
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product, applicationUserName: customerIOId);
    final isBought = await instance.buyNonConsumable(purchaseParam: purchaseParam);
    return isBought;
  }

  Future<void> finishTransactionIOS() async {
    final paymentWrapper = SKPaymentQueueWrapper();
    final transactions = await paymentWrapper.transactions();
    await Future.wait(transactions.map((transaction) => paymentWrapper.finishTransaction(transaction)));
  }

  Future<void> completePurchase(PurchaseDetails? purchaseDetails) async {
    if (purchaseDetails != null && purchaseDetails.pendingCompletePurchase) {
      try {
        await instance.completePurchase(purchaseDetails);
      } catch (e) {
        debugPrint('devcpp completePurchase: ${e.toString()} ');
        return;
      }
    }
    return;
  }

  Future<void> restorePurchase() async => await instance.restorePurchases();
}
