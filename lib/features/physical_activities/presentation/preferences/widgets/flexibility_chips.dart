import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/flexibility_option.dart';
import 'package:loopcare_frontend/core/domain/multi_choice_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';

class FlexibilityChips extends StatefulWidget {
  const FlexibilityChips({super.key});

  @override
  State<FlexibilityChips> createState() => _FlexibilityChipsState();
}

class _FlexibilityChipsState extends State<FlexibilityChips> {
  FlexibilityOption? _selectedValue;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    var flexibleVar = bloc.state.data.flexible;
    if (flexibleVar != null) {
      _selectedValue = flexibleVar ? FlexibilityOption.more : null;
    }
  }

  void _onSelectedHandler(FlexibilityOption value) {
    setState(() {
      _selectedValue = _selectedValue == value ? null : value;
    });

    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    bloc.add(PhysicalActivitiesPreferencesEvent.setFlexible(_selectedValue == null ? false : true));
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
