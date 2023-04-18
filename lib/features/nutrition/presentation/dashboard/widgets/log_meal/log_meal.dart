import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class LogMeal extends StatelessWidget {
  final bool isEditable;

  const LogMeal({
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
              const Image(
                image: AppIcons.dashbordLogMeals,
              ),
              const SizedBox(width: 24.0),
              // TODO get data from the user bloc
              Text(
                LocalizedTexts.logYourMeals.translation,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontFamily: ThemeConstants.bitterFontFamily,
                    ),
              ),
            ],
          ),
          Hexagon(
            width: 54,
            height: 54,
            borderRadius: 16,
            innerWidget: Container(
              color: AppColors.bgGreen,
              child: IconButton(
                icon: ImageIcon(
                  isEditable ? AppIcons.edit : AppIcons.plus,
                  color: AppColors.darkGreen,
                  size: 18,
                ),
                onPressed: () => onPressHandler(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
