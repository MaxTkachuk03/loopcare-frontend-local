import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/alert_box.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/application/delete_weekly_goal_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_goal_delete_alert.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import '../dashboard_smart_goals.dart';

@RoutePage()
class DeleteWeeklyGoals extends StatelessWidget {
  const DeleteWeeklyGoals({super.key});
  void handleDelete(BuildContext context, List<int> selectedItems) async {
    try {
      context
          .read<SmartGoalsBloc>()
          .add(SmartGoalsEvent.multiDeleteSession(sessionIds: selectedItems.toList()));

      await Future.delayed(const Duration(seconds: 1));
      Future.microtask(() {
        if (context.mounted) {
          context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());
          // Navigator.pop(context);
          context.router.maybePop();
        }
      });
    } catch (e) {
      log("Error deleting sessions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.smartGoalsMyGoals.tr(),
        leading: CustomFilledIconButton.leadingBlueLighter(),
      ),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<DeleteWeeklyGoalBloc>(create: (context) => DeleteWeeklyGoalBloc()),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.bitter700(
                  LocalizedTexts.deleteGoal.tr(),
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(height: 10),
                CustomText.bitter100(
                  LocalizedTexts.selectGoal.tr(),
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(height: 15),
                // Combined BlocBuilder
                BlocBuilder<SmartGoalsBloc, SmartGoalsState>(builder: (context, state) {
                  return BlocBuilder<DeleteWeeklyGoalBloc, DeleteWeeklyGoalState>(
                    builder: (context, state) {
                      Set<int> selectedItems = <int>{};
                      if (state is SelectionUpdatedState) {
                        selectedItems = state.selectedItemIds;
                      }
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DashboardSmartGoals(
                              selectedItems: selectedItems,
                              showSmartGoalsCard: true,
                              isDeleteModule: true,
                              onTap: (WeeklyGoalsSession item) {
                                context.read<DeleteWeeklyGoalBloc>().add(
                                      ToggleItemSelectionEvent(item),
                                    );
                              },
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomElevatedButton.greyBorder(
                                key: const ValueKey('delete_button'),
                                onPressed: () {
                                  AlertBox.goalDeleteAlertBox(
                                      context: context,
                                      content: WeeklyGoalDeleteAlert(onRemove: () {
                                        handleDelete(context, selectedItems.toList());
                                      }));
                                },
                                label: LocalizedTexts.deleteGoal.tr(),
                                isLoading: false,
                                styles: selectedItems.isEmpty
                                    ? ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                          color: AppColors.greyLight,
                                        ),
                                        backgroundColor: AppColors.blueLightest,
                                        minimumSize: ButtonStyles.fullWidthSize,
                                        foregroundColor: AppColors.greyLight,
                                        textStyle: ButtonStyles.fullWidthLabel,
                                        elevation: 0)
                                    : null,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          )),
    );
  }
}
