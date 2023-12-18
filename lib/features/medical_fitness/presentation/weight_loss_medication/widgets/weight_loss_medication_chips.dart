import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/weight_loss_medication_answers.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class WeightLossMedicationChips extends StatefulWidget {
  const WeightLossMedicationChips({super.key});

  @override
  State<WeightLossMedicationChips> createState() => _WeightLossMedicationChipsState();
}

class _WeightLossMedicationChipsState extends State<WeightLossMedicationChips> {
  WeightLossMedicationAnswer? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<MedicalFitnessBloc>();

    _selectedValue = bloc.state.weightLossMedication;

    super.initState();
  }

  void _onSelectedMedicationHandler(WeightLossMedicationAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    final bloc = context.read<MedicalFitnessBloc>();

    bloc.add(MedicalFitnessEvent.weightLossMedicationChanged(value));

    if (value != WeightLossMedicationAnswer.no) {
      context.router.pushNamed(AppRoutes.medicationPastPeriod);

      return;
    }

    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: WeightLossMedicationAnswer.values
          .map(
            (WeightLossMedicationAnswer value) => Column(
              children: [
                AppChoiceChip(
                  label: value.label,
                  selected: value == _selectedValue,
                  value: value,
                  chipHeight: 50.0,
                  onSelected: _onSelectedMedicationHandler,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }
}
