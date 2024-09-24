import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_difficulty_question.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_place_question.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_type_question.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class ProgramTab extends StatelessWidget {
  const ProgramTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgramTypeQuestion(),
              SizedBox(height: 24.0),
              ProgramPlaceQuestion(),
              SizedBox(height: 24.0),
              ProgramDifficultyQuestion()
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: CustomElevatedButton.blueFullWidth(
              onPressed: () => _onNextPressed(context),
              label: LocalizedTexts.next.tr(),
            ),
          ),
        ],
      ),
    );
  }

  void _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.chooseProgram);
  }
}
