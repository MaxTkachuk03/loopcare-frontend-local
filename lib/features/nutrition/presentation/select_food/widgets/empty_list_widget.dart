import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EmptyListWidget extends StatelessWidget {
  final EmptyListType type;
  final String typeText;
  const EmptyListWidget({
    Key? key,
    required this.type,
    required this.typeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 2, thickness: 2, color: AppColors.bgGreen),
          Text(
            LocalizedTexts.youHaveNo,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.blueDark),
          ).tr(namedArgs: {
            'text': typeText,
          }),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: _getIcon(type),
                width: 16.0,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  type == EmptyListType.myFavorites
                      ? LocalizedTexts.favoritesExplain.translation
                      : LocalizedTexts.dishesExplain.translation,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            type == EmptyListType.myFavorites
                ? LocalizedTexts.favoritesList.translation
                : LocalizedTexts.dishesList.translation,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

enum EmptyListType {
  myFavorites,
  myDishes,
}

AssetImage _getIcon(EmptyListType type) {
  if (type == EmptyListType.myFavorites) {
    return AppIcons.starFilled;
  }
  if (type == EmptyListType.myDishes) {
    return AppIcons.pan;
  }

  return AppIcons.cutlery;
}
