import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum MealCategory {
  breakfast,
  lunch,
  dinner,
  inbetweens,
  // drinks,
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

  String get name {
    switch (this) {
      case MealCategory.breakfast:
        return LocalizedTexts.breakfast.tr();
      case MealCategory.lunch:
        return LocalizedTexts.lunch.tr();
      case MealCategory.dinner:
        return LocalizedTexts.dinner.tr();
      case MealCategory.inbetweens:
        return LocalizedTexts.inbetweens.tr();
      // case MealCategory.drinks:
      //   return LocalizedTexts.drinks.tr();
      default:
        return '';
    }
  }

  String? get label {
    switch (this) {
      case MealCategory.breakfast:
        return LocalizedTexts.breakfast.tr().toLowerCase();
      case MealCategory.lunch:
        return LocalizedTexts.lunch.tr().toLowerCase();
      case MealCategory.dinner:
        return LocalizedTexts.dinner.tr().toLowerCase();
      case MealCategory.inbetweens:
        return LocalizedTexts.inbetweens.tr().toLowerCase();
      // case MealCategory.drinks:
      //   return LocalizedTexts.drinks.tr().toLowerCase();
      default:
        return null;
    }
  }

  String? get shortLabel {
    switch (this) {
      case MealCategory.breakfast:
        return LocalizedTexts.breakfast.tr().toLowerCase();
      case MealCategory.lunch:
        return LocalizedTexts.lunch.tr().toLowerCase();
      case MealCategory.dinner:
        return LocalizedTexts.dinner.tr().toLowerCase();
      case MealCategory.inbetweens:
        return LocalizedTexts.inbetweensShort.tr().toLowerCase();
      // case MealCategory.drinks:
      //   return LocalizedTexts.drinks.tr().toLowerCase();
      default:
        return null;
    }
  }

  String? get originalValue {
    switch (this) {
      case MealCategory.breakfast:
        return 'breakfast';
      case MealCategory.lunch:
        return 'lunch';
      case MealCategory.dinner:
        return 'dinner';
      case MealCategory.inbetweens:
        return 'inbetweens & snacks';
      // case MealCategory.drinks:
      //   return 'drinks';
      default:
        return null;
    }
  }

  String get shortValue {
    switch (this) {
      case MealCategory.breakfast:
        return 'breakfast';
      case MealCategory.lunch:
        return 'lunch';
      case MealCategory.dinner:
        return 'dinner';
      case MealCategory.inbetweens:
        return 'inbetweens';
      // case MealCategory.drinks:
      //   return 'drinks';
      default:
        return '';
    }
  }
}
