import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';

enum SearchItemTypes {
  @JsonValue("favorite")
  favorite,

  @JsonValue("food")
  food,

  @JsonValue("dish")
  dish,

  @JsonValue("recipe")
  recipe,

  @JsonValue("recent")
  recent,
}

extension SearchItemTypesX on SearchItemTypes {
  AssetImage get icon {
    switch (this) {
      case SearchItemTypes.favorite:
        return AppIcons.starFilled;
      case SearchItemTypes.dish:
        return AppIcons.pan;
      case SearchItemTypes.food:
      case SearchItemTypes.recent:
        return AppIcons.magnifyingGlass;
      case SearchItemTypes.recipe:
        return AppIcons.cook;
      default:
        return AppIcons.magnifyingGlass;
    }
  }

  SearchMode get searchModeValue {
    switch (this) {
      case SearchItemTypes.food:
        return SearchMode.food;
      case SearchItemTypes.dish:
        return SearchMode.dish;
      case SearchItemTypes.recipe:
        return SearchMode.recipe;
      case SearchItemTypes.favorite:
        return SearchMode.favorite;
      default:
        return SearchMode.recipe;
    }
  }
}
