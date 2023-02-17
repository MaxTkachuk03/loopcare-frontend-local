import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/questions_wizard.dart';
import 'package:loopcare_frontend/features/self_help/gender_preferences/self_help_gender_preferences_chips.dart';

class SelfHelpGenderPreferencesPage extends StatelessWidget {
  const SelfHelpGenderPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionsWizard(
      stepTitle: LocalizedTexts.selfHelpTitle.tr(),
      currentStep:
          LocalizedTexts.currentStep.translation.translateWithNamedArgs({
        'currentStep': "1",
        'totalSteps': "1",
      }),
      question: Text(
        LocalizedTexts.selfHelpGenderPreferencesPage1Header.tr(),
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      questionList: const SelfHelpGenderPreferencesChips(),
      onNextPressed: () {},
    );
  }
}
