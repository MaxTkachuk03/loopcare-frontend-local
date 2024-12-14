import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

mixin AccesColorMapper {
  Color get regularColor => switch (this) {
        SubscriptionAccessType.limit => AppColors.coralRegular,
        SubscriptionAccessType.lifetime => AppColors.yellowRegular,
        SubscriptionAccessType.recommended => AppColors.coralRegular,
        SubscriptionAccessType.flexible => AppColors.orangeRegular,
        AccesColorMapper() => AppColors.coralRegular,
      };
}

enum SubscriptionAccessType with AccesColorMapper {
  limit,
  lifetime,
  flexible,
  recommended;

  String get label => switch (this) {
        limit => LocalizedTexts.subscriptionLimitedAccess.tr(),
        lifetime => LocalizedTexts.subscriptionLifeTimeAccess.tr(),
        flexible => LocalizedTexts.subscriptionFlexibleAccess.tr(),
        recommended => LocalizedTexts.subscriptionRecommendedAccess.tr(),
      };

  bool get isLimit => this == limit;

  bool get isLifetime => this == lifetime;

  bool get isFlexible => this == flexible;

  bool get isRecommended => this == recommended;
}
