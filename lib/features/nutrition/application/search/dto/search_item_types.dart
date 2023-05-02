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

  @JsonValue("receipe")
  receipe;
}

extension SearchItemTypesX on SearchItemTypes {
  AssetImage get icon {
    switch (this) {
      case SearchItemTypes.favorite:
        return AppIcons.starFilled;
      case SearchItemTypes.food:
        return AppIcons.pan;
      case SearchItemTypes.dish:
        return AppIcons.magnifyingGlass;
      case SearchItemTypes.receipe:
        return AppIcons.cook;

      default:
        return AppIcons.magnifyingGlass;
    }
  }
}
