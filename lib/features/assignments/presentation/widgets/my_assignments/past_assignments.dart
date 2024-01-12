import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/dashboard_assignments/assignment_list_item.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';

class PastAssignments extends StatelessWidget {
  final List<LessonQuestion> questions;
  final Function(int lessonId) onBtnPressed;

  const PastAssignments({
    super.key,
    required this.questions,
    required this.onBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.bitter600(
          LocalizedTexts.pastAssignments.translation.capitalize(),
          style: context.textTheme.bodyLarge,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            var question = questions[index];
            return AssignmentListItem(
              isComplete: question.completedAt != null,
              isOpen: question.isEditable,
              onDashboard: false,
              item: question,
              onBtnPressed: (int lessonId) => onBtnPressed(lessonId),
            );
          },
        ),
      ],
    );
  }
}
