import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/subscription/domain/sku_product.dart';
import 'package:loopcare_frontend/features/subscription/domain/subscription_image_data.dart';
import 'package:loopcare_frontend/features/subscription/domain/subscription_translation.dart';

class PurchasableProduct {
  final bool showBadge;
  final bool isOfferEligible;
  final ProductDetails details;
  final SkuProduct skuProduct;
  final SubscriptionTranslation? subscriptionTranslation;
  final List<SubscriptionImageData>? carouselImages;

  const PurchasableProduct({
    required this.details,
    required this.skuProduct,
    required this.isOfferEligible,
    this.showBadge = false,
    this.subscriptionTranslation,
    this.carouselImages,
  });

  bool get isEligible =>
      Platform.isIOS ? isOfferEligible : isOfferEligible && skuProduct.offerId != null;

  List<SubscriptionImageData> get images => carouselImages ?? [];

  String get roundPrice => details.rawPrice.toStringAsFixed(2);

  String get priceWithCurrency =>
      (_currency == '\$' || _currency == '£') ? '$_currency$roundPrice' : '$roundPrice$_currency';

  String get description => isEligible ? _descriptionOffer : _descriptionRegular;

  String get title => isEligible ? _titleOffer : _titleRegular;

  bool get isPricedOffer =>
      skuProduct.offerPriceAmount > 0 && isEligible;

  String? get badgeUrl => isPricedOffer ? subscriptionTranslation?.badge : null;

  String get _titleOffer =>
      '$priceWithCurrency / ${subscriptionTranslation?.customBillingPeriodText ?? ''}';

  String get _titleRegular =>
      '$priceWithCurrency / ${subscriptionTranslation?.customBillingPeriodText ?? ''}';

  String get _descriptionOffer => subscriptionTranslation?.offerDescription ?? '';

  String get _descriptionRegular => LocalizedTexts.subscriptionSubscribe.tr();

  String get _currency => _getCurrency(details.currencyCode);

  String _getCurrency(String currencyCode) => NumberFormat().simpleCurrencySymbol(currencyCode);
}
