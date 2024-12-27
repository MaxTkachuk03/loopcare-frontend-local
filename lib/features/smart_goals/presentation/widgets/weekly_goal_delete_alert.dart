import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class WeeklyGoalDeleteAlert extends StatelessWidget {
  final Function() onRemove;

  const WeeklyGoalDeleteAlert({
    super.key,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8.0),
        const CircleAvatar(
          radius: 22.0,
          backgroundColor: AppColors.coralRegular,
          child: Icon(Icons.info_outline_rounded),
        ),
        const SizedBox(height: 14.0),
        CustomText.w700(
          LocalizedTexts.smartGoalsDeleteGoalTitle.tr(),
          style: context.textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15.0),
        CustomText.w800(
          LocalizedTexts.areYouSureToDelete.tr(),
          style: context.textTheme.labelMedium,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 15.0),
        CustomText.w400(
          LocalizedTexts.loseProgress.tr(),
          style: context.textTheme.labelSmall,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20.0),
        CustomOutlinedButton.blueFullWidth(
          onPressed: context.router.maybePop,
          label: LocalizedTexts.takeBack.tr(),
        ),
        const SizedBox(height: 16.0),
        CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.yesDeleteGoal.tr(),
            onPressed: () {
              context.router.maybePop();
              onRemove();
            }),
      ],
    );
  }
}
