import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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
                CustomText.w600(
                  LocalizedTexts.physicalActivitiesNoActivities.tr(),
                  style: context.textTheme.bodySmall,
                ),
                CustomText.w600(
                  LocalizedTexts.physicalActivitiesFrequencyZero.tr(),
                  style: context.textTheme.bodySmall,
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
