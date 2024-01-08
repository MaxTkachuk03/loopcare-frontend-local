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
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medication_past_period/widgets/medication_past_period_chips.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class MedicationPastPeriodPage extends StatelessWidget {
  const MedicationPastPeriodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      isWithOnWillPop: false,
      child: CustomScaffold(
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.medicalIntroTitle.tr(),
          subtitle: LocalizedTexts.stepCounter.tr(args: ['3', '16']),
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
                        '${LocalizedTexts.medicationPastPeriodQuestion.tr()}?',
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 36.0),
                      const MedicationPastPeriodChips(),
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
