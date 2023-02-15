import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/diabetes_types.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class DiabetesTypeChips extends StatefulWidget {
  const DiabetesTypeChips({Key? key}) : super(key: key);

  @override
  State<DiabetesTypeChips> createState() => _DiabetesTypeChipsState();
}

class _DiabetesTypeChipsState extends State<DiabetesTypeChips> {
  DiabetesTypes? _selectedValue;

  @override
  void initState() {
    context.read<DiabetesBloc>().add(const DiabetesEvent.fetchDiabetesTypes());

    super.initState();
  }

  void _onSelectedDiabetesTypeHandler(DiabetesTypes value) {
    setState(() {
      _selectedValue = value;
    });

    if (value == DiabetesTypes.typeOne || value == DiabetesTypes.typeTwo) {
      context.router.pushNamed(AppRoutes.diabetesDisclaimer);

      return;
    }

    context.router.pushNamed(AppRoutes.diabetesSummary);
    // final bloc = context.read<MedicalFitnessBloc>();

    // bloc.add(MedicalFitnessEvent.painInChestChanged(value));

    // final medicalFitnessNavigationState = StepNavigationState.of(context);

    // medicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    print('build method ${context.read<DiabetesBloc>().state}');
    return Column(
      children: DiabetesTypes.values
          .map(
            (DiabetesTypes value) => Column(
              children: [
                AppChoiceChip(
                  label: value.label,
                  selected: value == _selectedValue,
                  value: value,
                  textAlign: TextAlign.left,
                  onSelected: _onSelectedDiabetesTypeHandler,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }
}
