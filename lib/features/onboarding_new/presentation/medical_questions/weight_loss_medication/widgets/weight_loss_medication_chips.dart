import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/weight_loss_medication_answers.dart';

class WeightLossMedicationChips extends StatefulWidget {
  const WeightLossMedicationChips({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final WeightLossMedicationAnswer? initialValue;
  final void Function(WeightLossMedicationAnswer value) onChanged;


  @override
  State<WeightLossMedicationChips> createState() => _WeightLossMedicationChipsState();
}

class _WeightLossMedicationChipsState extends State<WeightLossMedicationChips> {
  WeightLossMedicationAnswer? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _onSelected(WeightLossMedicationAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: WeightLossMedicationAnswer.values
          .map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomChoiceChip.coral(
                label: item.label,
                selected: item == _selectedValue,
                onSelected: _onSelected,
                value: item,
              ),
            ))
          .toList(),
    );
  }
}
