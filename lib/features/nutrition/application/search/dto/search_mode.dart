import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

enum SearchMode {
  recipe,
  food,
  dish,
  favorite,
}

extension SearchModeX on SearchMode {
  String get label {
    switch (this) {
      case SearchMode.recipe:
        return LocalizedTexts.searchFilterRecipes.tr();
      case SearchMode.food:
        return LocalizedTexts.searchFilterProducts.tr();
      case SearchMode.dish:
        return LocalizedTexts.searchFilterMy.tr();
      case SearchMode.favorite:
        return LocalizedTexts.favorite.tr();
    }
  }

  String get searchModeValue {
    switch (this) {
      case SearchMode.recipe:
        return SearchMode.recipe.name;
      case SearchMode.food:
        return SearchMode.food.name;
      case SearchMode.dish:
        return SearchMode.dish.name;
      case SearchMode.favorite:
        return SearchMode.favorite.name;
    }
  }
}
