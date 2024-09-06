import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum MealCategory {
  breakfast,
  lunch,
  dinner,
  inbetweens;
  // drinks,

  String get title => switch (this) {
        breakfast => LocalizedTexts.breakfast.tr(),
        lunch => LocalizedTexts.lunch.tr(),
        dinner => LocalizedTexts.dinner.tr(),
        inbetweens => LocalizedTexts.inbetweens.tr(),
        //drinks => LocalizedTexts.drinks.tr(),
      };
}

extension MealCategoryExtension on MealCategory {
  SvgPicture get icon {
    switch (this) {
      case MealCategory.breakfast:
        return AppIcons.restaurant;
      case MealCategory.lunch:
        return AppIcons.restaurant;
      case MealCategory.dinner:
        return AppIcons.restaurant;
      case MealCategory.inbetweens:
        return AppIcons.fruit;
      // case MealCategory.drinks:
      //   return AppIcons.drinkSVG;
      default:
        return AppIcons.checkmarkSVG;
    }
  }

  String get originalValue {
    switch (this) {
      case MealCategory.breakfast:
        return 'breakfast';
      case MealCategory.lunch:
        return 'lunch';
      case MealCategory.dinner:
        return 'dinner';
        // TODO: ask BE make this value "inbetweens"
      case MealCategory.inbetweens:
        return 'inbetweens & snacks';
      // case MealCategory.drinks:
      //   return 'drinks';
    }
  }
}
