import 'package:in_app_purchase/in_app_purchase.dart';

class PurchasableProduct {
  final ProductDetails? details;
  final double offer;
  final double regularPrice;
  final String currency;
  final bool recommended;

  const PurchasableProduct({
    this.details,
    required this.offer,
    required this.regularPrice,
    required this.currency,
    this.recommended = false,
  });
}
