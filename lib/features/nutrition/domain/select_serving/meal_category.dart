import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum MealCategory {
  breakfast,
  lunch,
  dinner,
  inbetweens,
  drinks,
}

extension MealCategoryExtension on MealCategory {
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
      case MealCategory.drinks:
        return LocalizedTexts.drinks.translation;
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
      case MealCategory.drinks:
        return LocalizedTexts.drinks.translation.toLowerCase();
      default:
        return null;
    }
  }
}
