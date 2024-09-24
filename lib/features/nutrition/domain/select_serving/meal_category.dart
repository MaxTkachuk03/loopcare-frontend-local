import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum MealCategory {
  breakfast,
  lunch,
  dinner,
  inbetweens;

  String get title => switch (this) {
        breakfast => LocalizedTexts.breakfast.tr(),
        lunch => LocalizedTexts.lunch.tr(),
        dinner => LocalizedTexts.dinner.tr(),
        inbetweens => LocalizedTexts.inbetweens.tr(),
      };

  SvgPicture get icon => switch (this) {
        MealCategory.breakfast => AppIcons.restaurant,
        MealCategory.lunch => AppIcons.restaurant,
        MealCategory.dinner => AppIcons.restaurant,
        MealCategory.inbetweens => AppIcons.fruit,
      };

  String get originalValue => switch (this) {
        MealCategory.breakfast => 'breakfast',
        MealCategory.lunch => 'lunch',
        MealCategory.dinner => 'dinner',
        MealCategory.inbetweens => 'inbetweens & snacks',
      };
}
