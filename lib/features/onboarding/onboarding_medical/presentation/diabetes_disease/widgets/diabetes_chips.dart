import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/diabetes_types.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class DiabetesChips extends StatefulWidget {
  const DiabetesChips({super.key});

  @override
  State<DiabetesChips> createState() => _DiabetesChipsState();
}

class _DiabetesChipsState extends State<DiabetesChips> {
  DiabetesTypes? _selectedValue;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<MedicalFitnessBloc>();

    if (bloc.state.data.diseasesList.contains(Diseases.diabetesTypeI)) {
      _selectedValue = DiabetesTypes.typeOne;
      return;
    }

    if (bloc.state.data.diseasesList.contains(Diseases.diabetesTypeII)) {
      _selectedValue = DiabetesTypes.typeTwo;
      return;
    }

    if (!bloc.state.data.diseasesList.contains(Diseases.diabetesTypeI) &&
        !bloc.state.data.diseasesList.contains(Diseases.diabetesTypeII)) {
      _selectedValue = DiabetesTypes.no;
      return;
    }
  }

  void _onSelected(DiabetesTypes value) {
    setState(() {
      _selectedValue = value;
    });

    final bloc = context.read<MedicalFitnessBloc>();

    bloc.add(const MedicalFitnessEvent.removeDisease(Diseases.diabetesTypeI));
    bloc.add(const MedicalFitnessEvent.removeDisease(Diseases.diabetesTypeII));

    if (value == DiabetesTypes.typeOne) {
      bloc.add(const MedicalFitnessEvent.addDisease(Diseases.diabetesTypeI));
    }

    if (value == DiabetesTypes.typeTwo) {
      bloc.add(const MedicalFitnessEvent.addDisease(Diseases.diabetesTypeII));
    }

    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = DiabetesTypes.values[i];

        return CustomChoiceChip.coral(
          label: item.label,
          selected: item == _selectedValue,
          onSelected: _onSelected,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: DiabetesTypes.values.length,
    );
  }
}
