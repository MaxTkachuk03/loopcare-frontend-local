import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/self_help/application/self_help_bloc.dart';
import 'package:loopcare_frontend/features/self_help/domain/prefer_gender_type.dart';

class SelfHelpGenderPreferencesChips extends StatefulWidget {
  const SelfHelpGenderPreferencesChips({Key? key}) : super(key: key);

  @override
  State<SelfHelpGenderPreferencesChips> createState() =>
      _SelfHelpGenderPreferencesChipsState();
}

class _SelfHelpGenderPreferencesChipsState
    extends State<SelfHelpGenderPreferencesChips> {
  PreferGenderType? _selectedValue;

  void _onSelected(PreferGenderType gender) {
    setState(() {
      _selectedValue = gender;
    });

    final bloc = context.read<SelfHelpBloc>();
    bloc.add(SelfHelpEvent.biologicalGenderChanged(gender));

    // final selfHelpNavigationState = StepNavigationState.of(context);
    // selfHelpNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PreferGenderType.values
          .map(
            (PreferGenderType value) => Column(
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
