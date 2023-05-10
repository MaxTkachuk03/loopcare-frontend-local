import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:json_annotation/json_annotation.dart';

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
      case SearchItemTypes.food:
        return AppIcons.pan;
      case SearchItemTypes.dish:
      case SearchItemTypes.recent:
        return AppIcons.magnifyingGlass;
      case SearchItemTypes.recipe:
        return AppIcons.cook;

      default:
        return AppIcons.magnifyingGlass;
    }
  }
}
