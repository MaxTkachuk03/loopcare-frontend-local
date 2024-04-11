import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/like_unlike_selector/like_unlike_selector.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/goal_review_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/goal_review_page/widgets/goal_review_card.dart';

class GoalReviewPage extends StatefulWidget {
  final WeeklySmartGoal goal;
  final bool isLast;

  const GoalReviewPage({super.key, required this.goal, required this.isLast});

  @override
  State<GoalReviewPage> createState() => _GoalReviewPageState();
}

class _GoalReviewPageState extends State<GoalReviewPage> {
  final _scoreValue = ValueNotifier<int?>(null);
  final _wantToTryValue = ValueNotifier<bool?>(null);

  @override
  void initState() {
    super.initState();

    final difficultyVal = widget.goal.difficulty ?? 0;

    _scoreValue.value = difficultyVal - 1;
    _wantToTryValue.value = widget.goal.isTryAgain;
  }

  void _onScorePressedHadnler(int? val) => _scoreValue.value = val;

  void _onWantToTryChangeHandler(bool val) => _wantToTryValue.value = val;

  void _onPressedHandler(BuildContext context) {
    final bloc = context.read<SmartGoalsBloc>();
    if (widget.isLast) {
      context.router.popUntilRoot();
    } else {
      final nextGoal = bloc.state.data.getNextGoalForReview(widget.goal);
      if (nextGoal == null) return;
      final isLast = context.read<SmartGoalsBloc>().state.data.isLastGoalInSession(nextGoal);

      context.router.push(GoalReviewRoute(goal: nextGoal, isLast: isLast));
    }

    // final data = GoalReviewBody(
    //     id: widget.goal.id, difficulty: _scoreValue.value ?? 0, isTryAgain: _wantToTryValue.value ?? false);
    //
    // context.read<SmartGoalsBloc>().add(SmartGoalsEvent.addReview(data));
  }

  String get _btnLabel => widget.isLast ? LocalizedTexts.confirm.tr() : LocalizedTexts.next.tr();

  void _onReviewAddedListener(BuildContext context, SmartGoalsState state) {
    state.mapOrNull(
      errorAddingReview: (s) => _onErrorAddingReview(context, s),
      reviewAdded: (s) => _onReviewAdded(context, s),
    );
  }

  void _onErrorAddingReview(BuildContext context, SmartGoalsState state) {
    final String? errorMessage = state.data.error?.maybeMap(
      forbidden: (s) => s.error.message,
      notFound: (s) => s.error.message,
      badRequest: (s) => s.error.message,
      orElse: () => LocalizedTexts.somethingWentWrong.tr(),
    );

    context.showError(content: CustomText.w400(errorMessage ?? ''));
  }

  void _onReviewAdded(BuildContext context, SmartGoalsState state) {
    if (widget.isLast) {
      context.router.popUntilRoot();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: LocalizedTexts.goalReview.tr(),
        leading: CustomFilledIconButton.leadingGreenLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: BlocListener<SmartGoalsBloc, SmartGoalsState>(
            listenWhen: (prev, cur) =>
                cur is GotSmartGoalsStateErrorAddingReview || cur is GotSmartGoalsStateReviewAdded,
            listener: _onReviewAddedListener,
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
                      ValueListenableBuilder(
                        valueListenable: _wantToTryValue,
                        builder: (context, value, _) => LikeUnlikeSelector(
                          onChange: _onWantToTryChangeHandler,
                          value: _wantToTryValue.value ?? false,
                        ),
                      ),
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
                            label: _btnLabel,
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
