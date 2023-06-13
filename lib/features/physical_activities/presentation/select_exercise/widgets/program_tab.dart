import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_question.dart';

class ProgramTab extends StatelessWidget {
  const ProgramTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgramQuestion(question: LocalizedTexts.whatWouldYouLikeToWorkOn,)
        ],
      ),
    );
  }
}
