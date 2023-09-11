import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/medication_past_period_answer.dart';

class MedicationPastPeriodChips extends StatefulWidget {
  const MedicationPastPeriodChips({Key? key}) : super(key: key);

  @override
  State<MedicationPastPeriodChips> createState() => _MedicationPastPeriodChipsState();
}

class _MedicationPastPeriodChipsState extends State<MedicationPastPeriodChips> {
  MedicationPastPeriodAnswer? _selectedValue;

  void _onSelectedMedicationPastPeriodHandler(MedicationPastPeriodAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    context.router.pushNamed(AppRoutes.medicationFuturePeriod);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: MedicationPastPeriodAnswer.values
          .map(
            (MedicationPastPeriodAnswer value) => Column(
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
