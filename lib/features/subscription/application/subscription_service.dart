import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppSubscriptionService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final Stream<List<PurchaseDetails>> storeSubscription = InAppPurchase.instance.purchaseStream;

  InAppPurchase get instance => _inAppPurchase;
  final List purchasedList = [];

  Future<List<ProductDetails>> getSubscriptionPlans(Set<String> main) async {
    final bool isAvailable = await _inAppPurchase.isAvailable();

    debugPrint('devcpp Get isAvailable: $isAvailable');
    if (!isAvailable) {
      return [];
    }
    final ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(main);
    debugPrint('devcpp  productDetails response: ${productDetailResponse.toString()}');
    debugPrint('devcpp  productDetails notFoundIDs: ${productDetailResponse.notFoundIDs}');
    debugPrint('devcpp  productDetails ERRROR: ${productDetailResponse.error}');

    if (productDetailResponse.error != null || productDetailResponse.productDetails.isEmpty) {
      debugPrint('devcpp  productDetails: ${productDetailResponse.productDetails}');
      return [];
    }
    for (final detail in productDetailResponse.productDetails) {
      debugPrint('devcpp  id: ${detail.id}');
      debugPrint('devcpp  title: ${detail.title}');
      debugPrint('devcpp  description: ${detail.description}');
      debugPrint('devcpp  price: ${detail.price}');
      debugPrint('devcpp  rawPrice: ${detail.rawPrice}');
      debugPrint('devcpp  currencySymbol: ${detail.currencySymbol}');
      debugPrint('devcpp  currencyCode: ${detail.currencyCode}');
    }

    return productDetailResponse.productDetails;
  }

  Future<bool> buyItemInStore(ProductDetails product) async {
    if (Platform.isIOS) {
      final paymentWrapper = SKPaymentQueueWrapper();
      final transactions = await paymentWrapper.transactions();
      await Future.wait(transactions.map((transaction) => paymentWrapper.finishTransaction(transaction)));
    }
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    debugPrint('devcpp start buyItemInStore ');
    final isBought = await instance.buyNonConsumable(purchaseParam: purchaseParam);
    debugPrint('devcpp start isBought: $isBought ');
    return isBought;
  }

  Future<void> completePurchase(PurchaseDetails purchaseDetails) async {
    await instance.completePurchase(purchaseDetails);
  }

  Future<void> restorePurchase() async => await instance.restorePurchases();
}
