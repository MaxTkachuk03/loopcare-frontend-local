import 'package:in_app_purchase/in_app_purchase.dart';

class PurchasedProduct {
  String get productID => purchaseDetails.productID;

  String? get purchaseID => purchaseDetails.purchaseID;

  String get serverVerificationData => purchaseDetails.verificationData.serverVerificationData;

  String get localVerificationData => purchaseDetails.verificationData.localVerificationData;
  PurchaseDetails purchaseDetails;
  String? memberSince;
  String? automaticRenewalOn;
  String? subscriptionVia;

  PurchasedProduct({
    required this.purchaseDetails,
    this.automaticRenewalOn,
    this.memberSince,
    this.subscriptionVia,
  });
}
