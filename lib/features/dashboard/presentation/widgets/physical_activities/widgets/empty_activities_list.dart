import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EmptyActivitiesList extends StatelessWidget {
  const EmptyActivitiesList({super.key});

  void onPressHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.physicalActivitiesFrequency);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressHandler(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocalizedTexts.physicalActivitiesNoActivities.tr(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGreen,
                  ),
                ),
                Text(
                  LocalizedTexts.physicalActivitiesFrequencyZero.tr(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGreen,
                  ),
                ),
              ],
            ),
          ),
          const ImageIcon(AppIcons.arrow, color: AppColors.greyLabel),
        ],
      ),
    );
  }
}
