import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/medication_future_period_answer.dart';
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
    return Column(
      children: MedicationFuturePeriodAnswer.values
          .map(
            (MedicationFuturePeriodAnswer value) => Column(
              children: [
                AppChoiceChip(
                  label: value.label,
                  selected: value == _selectedValue,
                  value: value,
                  chipHeight: 50.0,
                  onSelected: _onSelectedMedicationPastPeriodHandler,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }
}
