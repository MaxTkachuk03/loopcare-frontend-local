import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/like_unlike_block.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_review_card.dart';

class GoalReviewPage extends StatefulWidget {
  final WeeklySmartGoal goal;

  const GoalReviewPage({super.key, required this.goal});

  @override
  State<GoalReviewPage> createState() => _GoalReviewPageState();
}

class _GoalReviewPageState extends State<GoalReviewPage> {
  final _scoreValue = ValueNotifier<int?>(null);
  final _wantToTryValue = ValueNotifier<bool?>(null);

  void _onScorePressedHadnler(int? val) => _scoreValue.value = val;

  void _onWantToTryChangeHandler(bool val) => _wantToTryValue.value = val;

  void _onPressedHandler(BuildContext context) {}

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 28.0),
                    GoalReviewCard(item: widget.goal),
                    const SizedBox(height: 68.0),
                    CustomText.bitter600(
                      LocalizedTexts.howHardWasTheGoal.tr(),
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24.0),
                    ValueListenableBuilder(
                      valueListenable: _scoreValue,
                      builder: (context, value, _) => ScoringScale(
                        selectedScore: value,
                        selectedColor: AppColors.greenRegular,
                        scaleSize: 10,
                        borderColor: AppColors.blueDarker,
                        divColor: AppColors.blueLighter,
                        onScoreTap: _onScorePressedHadnler,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText.w600(LocalizedTexts.veryEasy.tr(), style: context.textTheme.bodySmall),
                        CustomText.w600(LocalizedTexts.veryHard.tr(), style: context.textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    CustomText.bitter600(
                      LocalizedTexts.wantToTryInFuture.tr(),
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 25.0),
                    LikeUnlikeBlock(onLikeChange: _onWantToTryChangeHandler)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: ValueListenableBuilder<int?>(
                    valueListenable: _scoreValue,
                    builder: (_, score, __) => ValueListenableBuilder<bool?>(
                      valueListenable: _wantToTryValue,
                      builder: (_, wantToTry, __) {
                        final bool canSend = score != null && wantToTry != null;

                        return CustomElevatedButton.blueFullWidth(
                          label: LocalizedTexts.next.tr(),
                          onPressed: canSend ? () => _onPressedHandler(context) : null,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scoreValue.dispose();
    _wantToTryValue.dispose();

    super.dispose();
  }
}
