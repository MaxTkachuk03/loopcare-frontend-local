import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_frequency.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';

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

    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    if (bloc.state.data.isFrequencySet) {
      _selectedValue = bloc.state.data.trainingFrequency;
    }
  }

  void _onSelectedHandler(PhysicalActivitiesFrequency value) {
    setState(() {
      _selectedValue = value;
    });

    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    bloc.add(PhysicalActivitiesPreferencesEvent.setFrequency(value));
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
