import 'package:in_app_purchase/in_app_purchase.dart';

 class PurchasableProduct {
  final ProductDetails? details;
  final double monthlyPrice;
  final double commonPrice;
  final String currency;
  final bool isAnnual;

  const PurchasableProduct({
    this.details,
    required this.monthlyPrice,
    required this.commonPrice,
    required this.currency,
    this.isAnnual = false,
  });
}
