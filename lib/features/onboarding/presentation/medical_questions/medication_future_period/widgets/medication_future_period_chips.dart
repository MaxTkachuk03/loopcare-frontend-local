import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/onboarding/domain/medication_future_period_answer.dart';

class MedicationFuturePeriodChips extends StatefulWidget {
  const MedicationFuturePeriodChips({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final MedicationFuturePeriodAnswer? initialValue;
  final void Function(MedicationFuturePeriodAnswer value) onChanged;

  @override
  State<MedicationFuturePeriodChips> createState() => _MedicationFuturePeriodChipsState();
}

class _MedicationFuturePeriodChipsState extends State<MedicationFuturePeriodChips> {
  MedicationFuturePeriodAnswer? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _onSelectedHandler(MedicationFuturePeriodAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: MedicationFuturePeriodAnswer.values
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
