import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';

class PurchasableProduct {
  final ProductDetails? details;
  final double offer;
  final double regularPrice;
  final String currency;
  final bool recommended;
  final String? localizationDescription;
  final String? localizationTitle;

  const PurchasableProduct({
    this.details,
    required this.offer,
    required this.regularPrice,
    required this.currency,
    this.recommended = false,
    this.localizationDescription,
    this.localizationTitle,
  });

  String get roundPrice => details?.rawPrice.toStringAsFixed(2) ?? '';

  String get _titleIOS => details?.title ?? '';

  String get _descriptionIOS => details?.description ?? '';

  String get _descriptionAndroid => localizationDescription ?? details?.description ?? '';

  String get _titleAndroid => localizationTitle ?? details?.title ?? '';

  String get description => Platform.isIOS ? _descriptionIOS : _descriptionAndroid;

  String get title => Platform.isIOS ? _titleIOS : _titleAndroid;

  String get priceWithCurrency =>
      (currency == '\$' || currency == '\£') ? '$currency$roundPrice' : '$roundPrice$currency';
}
