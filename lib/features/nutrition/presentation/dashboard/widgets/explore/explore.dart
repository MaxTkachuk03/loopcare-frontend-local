import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class Explore extends StatelessWidget {
  final bool isEditable;

  const Explore({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    // TODO do logic depends on editable weight block state
    context.router.pushNamed(AppRoutes.selectFood);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 55.0,
                child: Image(
                  image: AppIcons.dashbordExplore,
                ),
              ),
              const SizedBox(width: 24.0),
              Text(
                LocalizedTexts.explore.translation,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontFamily: ThemeConstants.bitterFontFamily,
                    ),
              ),
            ],
          ),
          const ImageIcon(
            AppIcons.arrow,
            color: AppColors.greyLabel,
          ),
        ],
      ),
    );
  }
}
