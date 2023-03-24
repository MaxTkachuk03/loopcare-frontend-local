import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum MealFavoritesCategory {
  breakfast,
  lunch,
  dinner,
  inbetweens,
  drinks,
  all
}

extension MealFavoritesCategoryExtension on MealFavoritesCategory {
  String get name {
    switch (this) {
      case MealFavoritesCategory.breakfast:
        return '${LocalizedTexts.breakfast.translation} ${LocalizedTexts.favorites.translation}';
      case MealFavoritesCategory.lunch:
        return '${LocalizedTexts.lunch.translation} ${LocalizedTexts.favorites.translation}';
      case MealFavoritesCategory.dinner:
        return '${LocalizedTexts.dinner.translation} ${LocalizedTexts.favorites.translation}';
      case MealFavoritesCategory.inbetweens:
        return '${LocalizedTexts.inbetweens.translation} ${LocalizedTexts.favorites.translation}';
      case MealFavoritesCategory.drinks:
        return '${LocalizedTexts.drinks.translation} ${LocalizedTexts.favorites.translation}';
        case MealFavoritesCategory.all:
        return '${LocalizedTexts.allMy.translation} ${LocalizedTexts.favorites.translation}';
      default:
        return '';
    }
  }

  String? get label {
    switch (this) {
      case MealFavoritesCategory.breakfast:
        return LocalizedTexts.breakfast.translation.toLowerCase();
      case MealFavoritesCategory.lunch:
        return LocalizedTexts.lunch.translation.toLowerCase();
      case MealFavoritesCategory.dinner:
        return LocalizedTexts.dinner.translation.toLowerCase();
      case MealFavoritesCategory.inbetweens:
        return LocalizedTexts.inbetweens.translation.toLowerCase();
      case MealFavoritesCategory.drinks:
        return LocalizedTexts.drinks.translation.toLowerCase();
      default:
        return null;
    }
  }
}
