//import for AppStoreProductDetails
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum Unit {
  day,
  week,
  month,
  year;

  String get label => switch (this) {
        day => LocalizedTexts.subscriptionDaily.tr(),
        week => LocalizedTexts.subscriptionWeekly.tr(),
        month => LocalizedTexts.subscriptionMonth.tr(),
        year => LocalizedTexts.subscriptionAnnual.tr(),
      };
}

Unit getIosUnit(String? value) {
  if (value == null) return Unit.month;
  return Unit.values.firstWhere((e) => e.name == value);
}

Unit getAndroidUnit(String? value) {
  if (value == null) return Unit.month;
  value = value.substring(value.length - 1, value.length).toLowerCase();
  return Unit.values.firstWhere((e) => e.name.substring(0, 1) == value);
}

int getAndroidCountUnit(String? value) {
  if (value == null) return 0;
  value = value.substring(1, value.length - 1);
  return int.parse(value);
}

class SkuProduct {
  final Unit unitOffer;
  final int unitOfferCount;
  final String? offerPrice;
  final double offerPriceAmount;
  final double regularPrice;
  final String? offerId;

  SkuProduct({
    required this.unitOffer,
    required this.regularPrice,
    this.unitOfferCount = 0,
    this.offerPriceAmount = 0,
    this.offerPrice,
    this.offerId,
  });
}
