import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/smart_goals/widgets/dashboard_weekly_goal_item.dart';
import 'package:loopcare_frontend/features/river/domain/river_icon_type.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';

class DashboardWeeklyGoals extends StatefulWidget {
  final bool isFuture;
  final bool isDeleteModule;
  final void Function(WeeklyGoalsSession item) onTap;
  final Set<int>? selectedItems;

  const DashboardWeeklyGoals({
    super.key,
    this.isFuture = false,
    required this.isDeleteModule,
    required this.onTap,
    this.selectedItems,
  });

  @override
  State<DashboardWeeklyGoals> createState() => _DashboardWeeklyGoalsState();
}

class _DashboardWeeklyGoalsState extends State<DashboardWeeklyGoals> {
  int itemKey = 0;

  @override
  void initState() {
    super.initState();
    context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());
  }

  void _onErrorRetryHandler() =>
      context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getWeeklyGoals());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(builder: (context, state) {
      return state.maybeMap(
        error: (s) => ErrorScreen(
          error: s.data.error!,
          onButtonPressed: _onErrorRetryHandler,
        ),
        orElse: () {
          // Handle case where there is no error.
          if (state.data.emptySessionState) {
            return const SizedBox.shrink();
          }
          itemKey = itemKey + 1;

          List<WeeklyGoalsSession> sessions = [...state.data.weeklyGoalsSessions];

          if (sessions.isNotEmpty && state.data.selectedDate != null) {
            final selectedDate = state.data.selectedDate?.dateOnly;

            // Proceed only if selectedDate is not null.
            if (selectedDate != null) {
              sessions = sessions
                  .where((session) => (session.startedAt != null &&
                      (selectedDate.isAfter(session.startedAt!.dateOnly) ||
                          selectedDate == session.startedAt!.dateOnly)))
                  .toList();
            }
          }

          final isGoalSession = sessions.where((session) =>
              session.goal != null &&
              session.goal!.smartGoal.category.type != RiverIconType.commitment.name);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!widget.isDeleteModule && isGoalSession.isNotEmpty)
                const Divider(
                  color: AppColors.blueLighter,
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              const SizedBox(height: 4.0),
              ...sessions.map(
                (session) {
                  if (isGoalSession.isNotEmpty) {
                    return DashboardWeeklyGoalItem(
                      isFuture: widget.isFuture,
                      keyItem: itemKey,
                      sessionId: session.id!,
                      isSelect: widget.selectedItems != null && widget.selectedItems!.isNotEmpty
                          ? widget.selectedItems!.contains(session.id)
                          : false,
                      onTap: () {
                        widget.onTap(session);
                      },
                      onRemoveFromLocal: () {
                        setState(() {
                          sessions.remove(session);
                        });
                      },
                      item: session.goal!,
                      editable: !(session.goal!.isAchieved || session.hasQuickReviewWeeklyGoals),
                      isDeleteModule: widget.isDeleteModule,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          );
        },
      );
    });
  }
}
