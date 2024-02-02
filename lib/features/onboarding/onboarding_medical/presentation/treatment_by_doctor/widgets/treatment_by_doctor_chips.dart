import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class TreatmentByDoctorChips extends StatefulWidget {
  const TreatmentByDoctorChips({super.key});

  @override
  State<TreatmentByDoctorChips> createState() => _TreatmentByDoctorChipsState();
}

class _TreatmentByDoctorChipsState extends State<TreatmentByDoctorChips> {
  YesNoAnswer? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<MedicalFitnessBloc>();

    _selectedValue = bloc.state.data.treatmentByTheDoctor;

    super.initState();
  }

  void _onSelectedHandler(YesNoAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    final bloc = context.read<MedicalFitnessBloc>();

    if (value == YesNoAnswer.yes || bloc.state.data.hasAtLeastOneDisease) {
      context.router.pushNamed(AppRoutes.medicalCheckFailed);
      bloc.add(MedicalFitnessEvent.treatmentByTheDoctorChanged(value));

      return;
    }

    bloc.add(MedicalFitnessEvent.treatmentByTheDoctorChanged(value));

    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = YesNoAnswer.values[i];

        return CustomChoiceChip.coral(
          label: item.label,
          selected: item == _selectedValue,
          onSelected: _onSelectedHandler,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: YesNoAnswer.values.length,
    );
  }
}
