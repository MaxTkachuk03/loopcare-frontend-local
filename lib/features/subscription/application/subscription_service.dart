import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppSubscriptionService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final Stream<List<PurchaseDetails>> storeSubscription = InAppPurchase.instance.purchaseStream;

  static  Set<String> main = {'monthly','annual'};
  // {'monthly','annual'};


  InAppPurchase get instance => _inAppPurchase;
  final List purchasedList = [];

  Future<List<ProductDetails>> getSubscriptionPlans() async {
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
    return productDetailResponse.productDetails;
  }

  Future<bool> buyItemInStore(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    return instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> completePurchase(PurchaseDetails purchaseDetails) async {
    await instance.completePurchase(purchaseDetails);
  }
}
