import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_goal_reason_chips.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class WeeklyGoalCancelReason extends StatelessWidget {
  final Function() onRemove;

  const WeeklyGoalCancelReason({
    super.key,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        const CircleAvatar(
          radius: 22.0,
          backgroundColor: AppColors.coralRegular,
          child: Icon(Icons.info_outline_rounded),
        ),
        const SizedBox(height: 14.0),
        CustomText.bitter600(
          LocalizedTexts.smartGoalsCancelGoalTitle.tr(),
          style: context.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32.0),
        CustomText.w400(
          LocalizedTexts.smartGoalsCancelGoalSubTitle.tr(),
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        const WeeklyGoalReasonChips(),
        const SizedBox(height: 28),
        CustomOutlinedButton.blueFullWidth(
          onPressed: context.router.maybePop,
          label: LocalizedTexts.cancel.tr(),
        ),
        const SizedBox(height: 16.0),
        BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
          builder: (context, state) {
            return CustomElevatedButton.blueFullWidth(
              label: LocalizedTexts.smartGoalsCancelGoal.tr(),
              onPressed: state.data.reason != null
                  ? () {
                      context.router.maybePop();
                      onRemove();
                    }
                  : null,
            );
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
