import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum MealFavoritesCategory { breakfast, lunch, dinner, inbetweens, drinks, all }

extension MealFavoritesCategoryExtension on MealFavoritesCategory {
  String get name {
    switch (this) {
      case MealFavoritesCategory.breakfast:
        return '${LocalizedTexts.breakfast.tr()} ${LocalizedTexts.favorites.tr()}';
      case MealFavoritesCategory.lunch:
        return '${LocalizedTexts.lunch.tr()} ${LocalizedTexts.favorites.tr()}';
      case MealFavoritesCategory.dinner:
        return '${LocalizedTexts.dinner.tr()} ${LocalizedTexts.favorites.tr()}';
      case MealFavoritesCategory.inbetweens:
        return '${LocalizedTexts.inbetweens.tr()} ${LocalizedTexts.favorites.tr()}';
      case MealFavoritesCategory.drinks:
        return '${LocalizedTexts.drinks.tr()} ${LocalizedTexts.favorites.tr()}';
      case MealFavoritesCategory.all:
        return '${LocalizedTexts.allMy.tr()} ${LocalizedTexts.favorites.tr()}';
      default:
        return '';
    }
  }

  String? get label {
    switch (this) {
      case MealFavoritesCategory.breakfast:
        return LocalizedTexts.breakfast.tr().toLowerCase();
      case MealFavoritesCategory.lunch:
        return LocalizedTexts.lunch.tr().toLowerCase();
      case MealFavoritesCategory.dinner:
        return LocalizedTexts.dinner.tr().toLowerCase();
      case MealFavoritesCategory.inbetweens:
        return LocalizedTexts.inbetweens.tr().toLowerCase();
      case MealFavoritesCategory.drinks:
        return LocalizedTexts.drinks.tr().toLowerCase();
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case MealFavoritesCategory.breakfast:
        return 'breakfast';
      case MealFavoritesCategory.lunch:
        return 'lunch';
      case MealFavoritesCategory.dinner:
        return 'dinner';
      case MealFavoritesCategory.inbetweens:
        return 'inbetweens & snacks';
      case MealFavoritesCategory.drinks:
        return 'drinks';
      default:
        return null;
    }
  }
}
