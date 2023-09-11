import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class TreatmentByDoctorChips extends StatefulWidget {
  const TreatmentByDoctorChips({Key? key}) : super(key: key);

  @override
  State<TreatmentByDoctorChips> createState() => _TreatmentByDoctorChipsState();
}

class _TreatmentByDoctorChipsState extends State<TreatmentByDoctorChips> {
  YesNoAnswer? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<MedicalFitnessBloc>();

    _selectedValue = bloc.state.treatmentByTheDoctor;

    super.initState();
  }

  void _onSelectedPregnancyHandler(YesNoAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    if (value == YesNoAnswer.yes) {
      context.router.pushNamed(AppRoutes.treatmentByDoctorFailed);

      return;
    }

    final bloc = context.read<MedicalFitnessBloc>();

    bloc.add(MedicalFitnessEvent.treatmentByTheDoctorChanged(value));

    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
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
              chipHeight: 50.0,
              onSelected: _onSelectedPregnancyHandler,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      )
          .toList(),
    );
  }
}
