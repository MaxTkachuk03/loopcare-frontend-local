import 'package:easy_localization/easy_localization.dart';
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
        return '${LocalizedTexts.breakfast.tr()} ${LocalizedTexts.dishes.tr()}';
      case DishFavoritesCategory.lunch:
        return '${LocalizedTexts.lunch.tr()} ${LocalizedTexts.dishes.tr()}';
      case DishFavoritesCategory.dinner:
        return '${LocalizedTexts.dinner.tr()} ${LocalizedTexts.dishes.tr()}';
      default:
        return '';
    }
  }

  String? get label {
    switch (this) {
      case DishFavoritesCategory.breakfast:
        return LocalizedTexts.breakfast.tr().toLowerCase();
      case DishFavoritesCategory.lunch:
        return LocalizedTexts.lunch.tr().toLowerCase();
      case DishFavoritesCategory.dinner:
        return LocalizedTexts.dinner.tr().toLowerCase();
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
