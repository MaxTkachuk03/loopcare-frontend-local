import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum DishFavoritesCategory {
  breakfast,
  lunch,
  dinner,
}

extension DishFavoritesCategoryExtension on DishFavoritesCategory {
  String get name {
    switch (this) {
      case DishFavoritesCategory.breakfast:
        return '${LocalizedTexts.breakfast.translation} ${LocalizedTexts.dishes.translation}';
      case DishFavoritesCategory.lunch:
        return '${LocalizedTexts.lunch.translation} ${LocalizedTexts.dishes.translation}';
      case DishFavoritesCategory.dinner:
        return '${LocalizedTexts.dinner.translation} ${LocalizedTexts.dishes.translation}';
      default:
        return '';
    }
  }

  String? get label {
    switch (this) {
      case DishFavoritesCategory.breakfast:
        return LocalizedTexts.breakfast.translation.toLowerCase();
      case DishFavoritesCategory.lunch:
        return LocalizedTexts.lunch.translation.toLowerCase();
      case DishFavoritesCategory.dinner:
        return LocalizedTexts.dinner.translation.toLowerCase();
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case DishFavoritesCategory.breakfast:
        return 'breakfast';
      case DishFavoritesCategory.lunch:
        return 'lunch';
      case DishFavoritesCategory.dinner:
        return 'dinner';
      default:
        return null;
    }
  }
}
