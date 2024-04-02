import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class SetWeeklyGoalsPage extends StatelessWidget {
  const SetWeeklyGoalsPage({super.key});

  void _onConfirmGoalsHandler() {}

  void _onAddGoalHandler(BuildContext context) => context.router.pushNamed(AppRoutes.selectGoalsCategory);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: LocalizedTexts.upcomingGoals.tr(),
        leading: CustomFilledIconButton.leadingGreenLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28.0),
                    CustomText.bitter600(
                      LocalizedTexts.upcomingGoalsTitle.tr(),
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 9.0),
                    CustomText.w400(
                      LocalizedTexts.upcomingGoalsDescription.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 50.0),
                    CustomText.w400(
                      LocalizedTexts.noGoalsSelected.tr(),
                      style: context.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 24.0),
                    CustomOutlinedButton.orange(
                      label: LocalizedTexts.addGoal.tr(),
                      onPressed: () => _onAddGoalHandler(context),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: CustomElevatedButton.blueFullWidth(
                    label: LocalizedTexts.confirmGoals.tr(),
                    onPressed: _onConfirmGoalsHandler,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
