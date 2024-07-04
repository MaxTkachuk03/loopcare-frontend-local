import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/dashboard_assignments/this_week_assignments_done.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/dashboard_assignments/this_week_assignments_open.dart';

class ThisWeekAssignments extends StatelessWidget {
  final List<dynamic> weekQuestions;
  final List<dynamic> todayQuestions;

  const ThisWeekAssignments({
    super.key,
    required this.weekQuestions,
    required this.todayQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (weekQuestions.isNotEmpty)
          ThisWeekAssignmentsOpen(
            questions: weekQuestions,
            onBtnPressed: (int lessonId) => _startLessonQuestion(context, lessonId),
          ),
        if (weekQuestions.isNotEmpty && todayQuestions.isNotEmpty)
          const Divider(color: AppColors.blueLighter),
        if (todayQuestions.isNotEmpty)
          ThisWeekAssignmentsDone(
            questions: todayQuestions,
            onBtnPressed: (int lessonId) => _startLessonQuestion(context, lessonId),
          ),
      ],
    );
  }

  _startLessonQuestion(BuildContext context, int lessonId) {
    context.router.push(
      AssignmentsIntroRoute(
        lessonId: lessonId,
        fromDashboard: true,
      ),
    );
  }
}
