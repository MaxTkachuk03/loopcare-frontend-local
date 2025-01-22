import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

enum SearchMode {
  food,
  recipe,
  favorite,
  dish,
}

extension SearchModeX on SearchMode {
  String get label {
    switch (this) {
      case SearchMode.recipe:
        return LocalizedTexts.searchFilterRecipes.tr();
      case SearchMode.food:
        return LocalizedTexts.searchFilterProducts.tr();
      case SearchMode.favorite:
        return LocalizedTexts.favorite.tr();
      case SearchMode.dish:
        return LocalizedTexts.searchFilterMy.tr();
    }
  }

  String get searchModeValue {
    switch (this) {
      case SearchMode.recipe:
        return SearchMode.recipe.name;
      case SearchMode.food:
        return SearchMode.food.name;
      case SearchMode.favorite:
        return SearchMode.favorite.name;
      case SearchMode.dish:
        return SearchMode.dish.name;
    }
  }
}
