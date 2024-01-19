import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/diabetes_disease/widgets/diabetes_chips.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class DiabetesDiseasePage extends StatelessWidget {
  const DiabetesDiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      child: CustomScaffold.blueLightest(
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.medicalIntroTitle.tr(),
          subtitle: LocalizedTexts.stepCounter.tr(args: ['10', '16']),
          leading: CustomFilledIconButton.leadingBlueLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              children: [
                ProgressBar.coral(backgroundColor: AppColors.blueRegular),
                MainContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 80.0),
                      CustomText.bitter600(
                        '${LocalizedTexts.diabetesQuestion.tr()}?',
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 36.0),
                      const DiabetesChips(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
