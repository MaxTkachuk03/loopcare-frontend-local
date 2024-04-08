import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
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
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_goals_list.dart';

class SetWeeklyGoalsPage extends StatefulWidget {
  const SetWeeklyGoalsPage({super.key});

  @override
  State<SetWeeklyGoalsPage> createState() => _SetWeeklyGoalsPageState();
}

class _SetWeeklyGoalsPageState extends State<SetWeeklyGoalsPage> {
  late SmartGoalsBloc goalsBloc;

  @override
  void initState() {
    super.initState();

    goalsBloc = context.read<SmartGoalsBloc>();
  }

  void _onConfirmGoalsHandler(BuildContext context) =>
      context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.saveGoals());

  void _onAddGoalHandler(BuildContext context) => context.router.pushNamed(AppRoutes.selectGoalsCategory);

  void _onSaveGoalsListener(BuildContext context, SmartGoalsState state) {
    state.mapOrNull(
      errorSaveGoals: (s) => _onErrorSaveWeeklyGoals(context, s),
      weeklySessionSaved: (s) => _onSaveWeeklyGoals(context, s),
    );
  }

  void _onErrorSaveWeeklyGoals(BuildContext context, SmartGoalsState state) {
    final String? errorMessage = state.data.error?.maybeMap(
      forbidden: (s) => s.error.message,
      notFound: (s) => s.error.message,
      badRequest: (s) => s.error.message,
      orElse: () => LocalizedTexts.somethingWentWrong.tr(),
    );

    context.showError(content: CustomText.w400(errorMessage ?? ''));
  }

  void _onSaveWeeklyGoals(BuildContext context, SmartGoalsState state) => context
    ..showSuccessBar(content: CustomText.w400(LocalizedTexts.saveWeeklyGoalsSuccessMessage.tr()))
    ..router.pop();

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
                    BlocConsumer<SmartGoalsBloc, SmartGoalsState>(
                      listener: _onSaveGoalsListener,
                      listenWhen: (prev, cur) =>
                          cur is SmartGoalsStateErrorSaveGoals || cur is SmartGoalsStateWeeklySessionSaved,
                      builder: (BuildContext context, SmartGoalsState state) {
                        return state.maybeMap(
                          orElse: () {
                            if (!state.data.hasSeelctedGoals) {
                              return CustomText.w400(
                                LocalizedTexts.noGoalsSelected.tr(),
                                style: context.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                              );
                            } else {
                              return const WeeklyGoalsList();
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),
                    BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
                      builder: (context, state) {
                        if (state.data.cantAddGoal) return const SizedBox.shrink();

                        return CustomOutlinedButton.orange(
                          label: LocalizedTexts.addGoal.tr(),
                          onPressed: () => _onAddGoalHandler(context),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
                    builder: (context, state) => CustomElevatedButton.blueFullWidth(
                      label: LocalizedTexts.confirmGoals.tr(),
                      onPressed: state.data.hasWeeklyGoals ? () => _onConfirmGoalsHandler(context) : null,
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
    goalsBloc.add(const SmartGoalsEvent.resetSelected());

    super.dispose();
  }
}
