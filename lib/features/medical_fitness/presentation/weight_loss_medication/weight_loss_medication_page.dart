import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/weight_loss_medication/widgets/weight_loss_medication_chips.dart';

class WeightLossMedicationPage extends StatelessWidget {
  const WeightLossMedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      child: MainContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 74.0,
            ),
            Text(
              LocalizedTexts.weightLossMedicationQuestion.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const WeightLossMedicationChips(),
          ],
        ),
      ),
    );
  }
}
