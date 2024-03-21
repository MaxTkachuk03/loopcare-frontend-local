import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/medication_past_period_answer.dart';

class MedicationPastPeriodChips extends StatefulWidget {
  const MedicationPastPeriodChips({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final MedicationPastPeriodAnswer? initialValue;
  final void Function(MedicationPastPeriodAnswer value) onChanged;

  @override
  State<MedicationPastPeriodChips> createState() => _MedicationPastPeriodChipsState();
}

class _MedicationPastPeriodChipsState extends State<MedicationPastPeriodChips> {
  MedicationPastPeriodAnswer? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _onSelectedHandler(MedicationPastPeriodAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: MedicationPastPeriodAnswer.values
          .map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomChoiceChip.coral(
                label: item.label,
                selected: item == _selectedValue,
                onSelected: _onSelectedHandler,
                value: item,
              ),
            ))
          .toList(),
    );
  }
}
