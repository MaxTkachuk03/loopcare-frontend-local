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
        return LocalizedTexts.searchFilterRecipes.translation;
      case SearchMode.food:
        return LocalizedTexts.searchFilterProducts.translation;
      case SearchMode.dish:
        return LocalizedTexts.searchFilterMy.translation;
      case SearchMode.favorite:
        return LocalizedTexts.favorite.translation;
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
