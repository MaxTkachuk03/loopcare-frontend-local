import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_multi_choice_chip.dart';

class ActivityTypeChips extends StatefulWidget {
  const ActivityTypeChips({Key? key}) : super(key: key);

  @override
  State<ActivityTypeChips> createState() => _ActivityTypeChipsState();
}

class _ActivityTypeChipsState extends State<ActivityTypeChips> {
  PhysicalActivitiesType? _selectedValue;

  @override
  void initState() {
    super.initState();
  }

  void _onSelectedHandler(PhysicalActivitiesType value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PhysicalActivitiesType.values
          .map(
            (PhysicalActivitiesType value) => Column(
              children: [
                AppChoiceChip(
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
