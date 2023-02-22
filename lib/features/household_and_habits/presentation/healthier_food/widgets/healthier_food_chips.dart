import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class HealthierFoodChips extends StatefulWidget {
  const HealthierFoodChips({Key? key}) : super(key: key);

  @override
  State<HealthierFoodChips> createState() => _HealthierFoodChipsState();
}

class _HealthierFoodChipsState extends State<HealthierFoodChips> {
  YesNoAnswer? _selectedValue;

  void _onSelected(YesNoAnswer value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: YesNoAnswer.values
          .map(
            (YesNoAnswer value) => Column(
              children: [
                AppChoiceChip(
                  label: value.label,
                  selected: value == _selectedValue,
                  value: value,
                  onSelected: _onSelected,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }
}
