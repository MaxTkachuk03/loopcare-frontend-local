import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/cardiovascular_disease_answers.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class CardiovascularDiseaseChips extends StatefulWidget {
  const CardiovascularDiseaseChips({Key? key}) : super(key: key);

  @override
  State<CardiovascularDiseaseChips> createState() =>
      _CardiovascularDiseaseChipsState();
}

class _CardiovascularDiseaseChipsState
    extends State<CardiovascularDiseaseChips> {
  CardiovascularDiseaseAnswers? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<MedicalFitnessBloc>();

    _selectedValue = bloc.state.cardiovascularDisease;

    super.initState();
  }

  void _onSelected(CardiovascularDiseaseAnswers value) {
    setState(() {
      _selectedValue = value;
    });

    context.read<ConsentConfirmationBloc>().add(
        ConsentConfirmationEvent.passageChanged(
            value == CardiovascularDiseaseAnswers.no));

    if (value == CardiovascularDiseaseAnswers.yes) {
      context.router.pushNamed(AppRoutes.cardiovascularDiseaseFailed);

      return;
    }

    final bloc = context.read<MedicalFitnessBloc>();

    bloc.add(MedicalFitnessEvent.cardiovascularDiseaseChanged(value));

    if (value == CardiovascularDiseaseAnswers.noBut) {
      context.router.pushNamed(AppRoutes.consentNeeded);

      return;
    }

    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: CardiovascularDiseaseAnswers.values
          .map(
            (CardiovascularDiseaseAnswers value) => Column(
              children: [
                AppChoiceChip(
                  label: value.label,
                  selected: value == _selectedValue,
                  value: value,
                  chipHeight: 50.0,
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
