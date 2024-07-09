import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/assignments/presentation/widgets/dashboard_assignments/assignment_list_item.dart';

class PastAssignments extends StatelessWidget {
  final List<dynamic> questions;
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
          LocalizedTexts.pastAssignments.tr().capitalize(),
          style: context.textTheme.bodyLarge,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            final question = questions[index];

            return AssignmentListItem(
              isComplete: question.isCompleted,
              isOpen: question.isEditable,
              onDashboard: false,
              item: question,
              onBtnPressed: onBtnPressed,
            );
          },
        ),
      ],
    );
  }
}
