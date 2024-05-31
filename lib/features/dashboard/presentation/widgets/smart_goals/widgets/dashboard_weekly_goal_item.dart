import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/goal_achieve_button.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/goal_progress_button.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/goal_progress_indicator.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_goal_cancel_reason.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_goal_info.dart';

const maxCompletions = 99;

class DashboardWeeklyGoalItem extends StatefulWidget {
  final int sessionId;
  final WeeklySmartGoal item;
  final bool editable;
  final int keyItem;
  final Function() onRemoveFromLocal;

  const DashboardWeeklyGoalItem({
    super.key,
    required this.item,
    required this.sessionId,
    required this.editable,
    required this.keyItem,
    required this.onRemoveFromLocal,
  });

  @override
  State<DashboardWeeklyGoalItem> createState() => _DashboardWeeklyGoalItemState();
}

class _DashboardWeeklyGoalItemState extends State<DashboardWeeklyGoalItem> {
  void _onProgressHandler(BuildContext context, WeeklySmartGoal item) {
    HapticFeedback.vibrate();
    context.read<SmartGoalsBloc>().add(SmartGoalsEvent.postCompletions(weeklySmartGoal: item));
  }

  void _onResetProgressHandler(BuildContext context, WeeklySmartGoal item) {
    HapticFeedback.vibrate();
    context.read<SmartGoalsBloc>().add(SmartGoalsEvent.resetCompletions(weeklySmartGoal: item));
  }

  void _onItemHandler(BuildContext context, WeeklySmartGoal item) => ModalBottomSheet.smartGoalComplete(
        context: context,
        content: WeeklyGoalInfo(
          weeklyGoal: item,
        ),
      );

  void _onQuickReviewHandler() {
    final goal = context.read<SmartGoalsBloc>().state.data.weeklyGoals.first;
    context.router.push(GoalReviewRoute(goal: goal));
  }

  void _onConfirmRemove(BuildContext context) {
    context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.resetCancelGoalReason());
    HapticFeedback.vibrate();
    ModalBottomSheet.smartGoalComplete(
      context: context,
      content: WeeklyGoalCancelReason(
        onRemove: _onRemove,
      ),
    );
  }

  void _onRemove() async =>
      context.read<SmartGoalsBloc>().add(SmartGoalsEvent.deleteSession(sessionId: widget.sessionId));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.transparent),
      ),
      clipBehavior: Clip.hardEdge,
      child: Slidable(
        key: ValueKey(widget.keyItem),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const StretchMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            widget.onRemoveFromLocal();
            _onConfirmRemove(context);
          }),
          children: [
            _SlideRemoveButton(
              onRemove: () => _onConfirmRemove(context),
            ),
          ],
        ),
        child: Card(
          color: AppColors.white,
          surfaceTintColor: AppColors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 8.0, right: 8.0),
            onTap: () => _onItemHandler(context, widget.item),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoalProgressIndicator(
                  currentStep: widget.item.completionsDays,
                  steps: widget.item.smartGoal.requiredCompletionDays,
                  isAchievedNotifier: widget.item.isAchieved,
                ),
                const SizedBox(width: 16.0),
                _LeftDaysWidget(item: widget.item),
                const SizedBox(width: 16.0),
              ],
            ),
            trailing: (widget.editable)
                ? GoalProgressButton(
                    item: widget.item,
                    onPressed: widget.item.completionsAmount < maxCompletions
                        ? () => _onProgressHandler(context, widget.item)
                        : null,
                    onResetProgress:
                        widget.item.completionsAmount > 0 ? () => _onResetProgressHandler(context, widget.item) : null,
                  )
                : GoalAchieveButton(
                    item: widget.item,
                    onPressed: _onQuickReviewHandler,
                  ),
          ),
        ),
      ),
    );
  }
}

class _SlideRemoveButton extends StatelessWidget {
  final Function()? onRemove;

  const _SlideRemoveButton({this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: onRemove,
          borderRadius: BorderRadius.circular(8),
          child: Container(
              margin: const EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(8)),
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}

class _LeftDaysWidget extends StatelessWidget {
  final WeeklySmartGoal item;

  const _LeftDaysWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.w600(
            item.shortTitle,
            style: context.textTheme.bodySmall,
          ),
          BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
            builder: (context, state) {
              final days = _getSubTitle(state);
              if (days.isNotEmpty) {
                return CustomText.w400(
                  days,
                  style: context.textTheme.bodySmall,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  String _getSubTitle(SmartGoalsState state) {
    if (!state.data.isWeeklySessionHasTimestamp) {
      return '';
    }
    if (state.data.hasActiveSession) {
      if (state.data.daysLeft > 1) {
        return LocalizedTexts.weeklyDaysLeft.tr(
          args: [state.data.daysLeft.toString()],
        );
      } else {
        return LocalizedTexts.weeklyDayLeft.tr(
          args: [state.data.daysLeft.toString()],
        );
      }
    } else if (state.data.hasQuickReviewWeeklyGoals) {
      if (state.data.daysReviewLeft > 1) {
        return LocalizedTexts.weeklyDaysReviewLeft.tr(
          args: [state.data.daysReviewLeft.toString()],
        );
      } else {
        return LocalizedTexts.weeklyDayReviewLeft.tr(
          args: [state.data.daysReviewLeft.toString()],
        );
      }
    }
    return '';
  }
}
