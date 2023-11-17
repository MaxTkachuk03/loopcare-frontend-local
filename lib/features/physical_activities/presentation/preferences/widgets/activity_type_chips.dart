import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/multi_choice_type.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';

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
    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    if (bloc.state.data.isTargetsSet) {
      _selectedValue = bloc.state.data.trainingTargets;
    }
  }

  void _onSelectedHandler(PhysicalActivitiesType value) {
    setState(() {
      _selectedValue = value;
    });

    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    bloc.add(PhysicalActivitiesPreferencesEvent.setTargets(value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PhysicalActivitiesType.values
          .map(
            (PhysicalActivitiesType value) => Column(
              children: [
                AppChoiceChip(
                  type: MultiChoiceType.radio,
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
