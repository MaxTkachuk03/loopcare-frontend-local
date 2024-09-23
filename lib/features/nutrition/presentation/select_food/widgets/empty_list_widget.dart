import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class EmptyListWidget extends StatelessWidget {
  final EmptyListType type;
  final String typeText;

  const EmptyListWidget({
    super.key,
    required this.type,
    required this.typeText,
  });

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          CustomText.bitter600(
            LocalizedTexts.youHaveNo.tr({
              'text': typeText,
            }),
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 24.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getIcon(type),
              const SizedBox(width: 12.0),
              Expanded(
                child: CustomText.w400(
                  type == EmptyListType.myFavorites
                      ? LocalizedTexts.favoritesExplain.tr()
                      : LocalizedTexts.dishesExplain.tr(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: context.textTheme.titleMedium,
                ),
              )
            ],
          ),
          const SizedBox(height: 8.0),
          CustomText.w400(
            type == EmptyListType.myFavorites
                ? LocalizedTexts.favoritesList.tr()
                : LocalizedTexts.dishesList.tr(),
            style: context.textTheme.titleSmall,
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

SvgPicture _getIcon(EmptyListType type) {
  if (type == EmptyListType.myFavorites) {
    return AppIcons.customStar;
  }
  if (type == EmptyListType.myDishes) {
    return AppIcons.customPan;
  }

  return AppIcons.customCutlery;
}
