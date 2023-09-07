import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/flexibility_option.dart';
import 'package:loopcare_frontend/core/domain/multi_choice_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class FlexibilityChips extends StatefulWidget {
  const FlexibilityChips({Key? key}) : super(key: key);

  @override
  State<FlexibilityChips> createState() => _FlexibilityChipsState();
}

class _FlexibilityChipsState extends State<FlexibilityChips> {
  FlexibilityOption? _selectedValue;

  @override
  void initState() {
    super.initState();
  }

  void _onSelectedHandler(FlexibilityOption value) {
    setState(() {
      _selectedValue = _selectedValue == value ? null : value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: FlexibilityOption.values
          .map(
            (FlexibilityOption value) => Column(
              children: [
                AppChoiceChip(
                  type: MultiChoiceType.checkbox,
                  textAlign: TextAlign.start,
                  label: value.label,
                  selected: value == _selectedValue,
                  value: value,
                  onSelected: _onSelectedHandler,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }
}
