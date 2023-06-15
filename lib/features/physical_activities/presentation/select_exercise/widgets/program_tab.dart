import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_difficulty_question.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_place_question.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_type_question.dart';

class ProgramTab extends StatelessWidget {
  const ProgramTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ProgramTypeQuestion(),
              SizedBox(
                height: 24.0,
              ),
              ProgramPlaceQuestion(),
              SizedBox(
                height: 24.0,
              ),
              ProgramDifficultyQuestion()
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: _onNextPressed,
                child: const Text(LocalizedTexts.next).tr(),
              ),
              const SizedBox(
                height: 54.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onNextPressed() {}
}
