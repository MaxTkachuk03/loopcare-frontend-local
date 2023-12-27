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
        return LocalizedTexts.breakfast.translation;
      case MealCategory.lunch:
        return LocalizedTexts.lunch.translation;
      case MealCategory.dinner:
        return LocalizedTexts.dinner.translation;
      case MealCategory.inbetweens:
        return LocalizedTexts.inbetweens.translation;
      // case MealCategory.drinks:
      //   return LocalizedTexts.drinks.translation;
      default:
        return '';
    }
  }

  String? get label {
    switch (this) {
      case MealCategory.breakfast:
        return LocalizedTexts.breakfast.translation.toLowerCase();
      case MealCategory.lunch:
        return LocalizedTexts.lunch.translation.toLowerCase();
      case MealCategory.dinner:
        return LocalizedTexts.dinner.translation.toLowerCase();
      case MealCategory.inbetweens:
        return LocalizedTexts.inbetweens.translation.toLowerCase();
      // case MealCategory.drinks:
      //   return LocalizedTexts.drinks.translation.toLowerCase();
      default:
        return null;
    }
  }

  String? get shortLabel {
    switch (this) {
      case MealCategory.breakfast:
        return LocalizedTexts.breakfast.translation.toLowerCase();
      case MealCategory.lunch:
        return LocalizedTexts.lunch.translation.toLowerCase();
      case MealCategory.dinner:
        return LocalizedTexts.dinner.translation.toLowerCase();
      case MealCategory.inbetweens:
        return LocalizedTexts.inbetweensShort.translation.toLowerCase();
      // case MealCategory.drinks:
      //   return LocalizedTexts.drinks.translation.toLowerCase();
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
