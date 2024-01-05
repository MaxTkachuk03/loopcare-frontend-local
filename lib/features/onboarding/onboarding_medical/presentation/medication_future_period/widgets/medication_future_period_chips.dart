import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/domain/medication_future_period_answer.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class MedicationFuturePeriodChips extends StatefulWidget {
  const MedicationFuturePeriodChips({super.key});

  @override
  State<MedicationFuturePeriodChips> createState() => _MedicationFuturePeriodChipsState();
}

class _MedicationFuturePeriodChipsState extends State<MedicationFuturePeriodChips> {
  MedicationFuturePeriodAnswer? _selectedValue;

  void _onSelectedMedicationPastPeriodHandler(MedicationFuturePeriodAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = MedicationFuturePeriodAnswer.values[i];

        return CustomChoiceChip.coral(
          label: item.label,
          selected: item == _selectedValue,
          onSelected: _onSelectedMedicationPastPeriodHandler,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: MedicationFuturePeriodAnswer.values.length,
    );
  }
}
