import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_frequency.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class FrequencyChips extends StatefulWidget {
  const FrequencyChips({Key? key}) : super(key: key);

  @override
  State<FrequencyChips> createState() => _FrequencyChipsState();
}

class _FrequencyChipsState extends State<FrequencyChips> {
  PhysicalActivitiesFrequency? _selectedValue;

  @override
  void initState() {
    // final bloc = context.read<MedicalFitnessBloc>();
    // _selectedValue = bloc.state.pregnancy;

    super.initState();
  }

  void _onSelectedHandler(PhysicalActivitiesFrequency value) {
    setState(() {
      _selectedValue = value;
    });

    if (value == YesNoAnswer.yes) {
      context.router.pushNamed(AppRoutes.pregnancyFailed);

      return;
    }

    // final bloc = context.read<MedicalFitnessBloc>();
    // bloc.add(MedicalFitnessEvent.pregnancyChanged(value));
    // final medicalFitnessNavigationState = StepNavigationState.of(context);

    // medicalFitnessNavigationState.onNextPage();
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
