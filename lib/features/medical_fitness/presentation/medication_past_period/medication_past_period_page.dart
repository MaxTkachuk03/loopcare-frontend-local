import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medication_past_period/widgets/medication_past_period_chips.dart';

class MedicationPastPeriodPage extends StatelessWidget {
  const MedicationPastPeriodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      isWithOnWillPop: false,
      child: MainContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 74.0,
            ),
            Text(
              LocalizedTexts.medicationPastPeriodQuestion.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const MedicationPastPeriodChips(),
          ],
        ),
      ),
    );
  }
}
