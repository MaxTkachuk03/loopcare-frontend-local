import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_frequency.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class FrequencyChips extends StatefulWidget {
  const FrequencyChips({Key? key}) : super(key: key);

  @override
  State<FrequencyChips> createState() => _FrequencyChipsState();
}

class _FrequencyChipsState extends State<FrequencyChips> {
  PhysicalActivitiesFrequency? _selectedValue;

  @override
  void initState() {
    super.initState();
  }

  void _onSelectedHandler(PhysicalActivitiesFrequency value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PhysicalActivitiesFrequency.values
          .map(
            (PhysicalActivitiesFrequency value) => Column(
              children: [
                AppChoiceChip(
                  textAlign: TextAlign.start,
                  label: value.label,
                  recommended: value.recommended,
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
