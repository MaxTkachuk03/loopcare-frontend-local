import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/questions_wizard.dart';
import 'package:loopcare_frontend/features/self_help/application/self_help_bloc.dart';
import 'package:loopcare_frontend/features/self_help/presentation/gender_preferences/self_help_gender_preferences_chips.dart';

class SelfHelpGenderPreferencesPage extends StatefulWidget {
  const SelfHelpGenderPreferencesPage({Key? key}) : super(key: key);

  @override
  State<SelfHelpGenderPreferencesPage> createState() =>
      _SelfHelpGenderPreferencesPageState();
}

class _SelfHelpGenderPreferencesPageState
    extends State<SelfHelpGenderPreferencesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfHelpBloc, SelfHelpState>(
      builder: (BuildContext context, state) {
        return QuestionsWizard(
          stepTitle: LocalizedTexts.selfHelpTitle.translation,
          currentStep:
              LocalizedTexts.currentStep.translation.translateWithNamedArgs(
            {
              'currentStep': "1",
              'totalSteps': "1",
            },
          ),
          question: Text(
            LocalizedTexts.selfHelpGenderPreferencesPage1Header.translation,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          questionList: const SelfHelpGenderPreferencesChips(),
          onNextPressed: () => state.selectedType != null || state.isCompleted
              ? context.router.pushNamed(AppRoutes.selfHelpReady)
              : null,
        );
      },
    );
  }
}
