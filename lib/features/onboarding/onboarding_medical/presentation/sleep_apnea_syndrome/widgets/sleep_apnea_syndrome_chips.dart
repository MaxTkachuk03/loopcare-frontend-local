import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class SleepApneaSyndromeChips extends StatefulWidget {
  const SleepApneaSyndromeChips({super.key});

  @override
  State<SleepApneaSyndromeChips> createState() => _SleepApneaSyndromeChipsState();
}

class _SleepApneaSyndromeChipsState extends State<SleepApneaSyndromeChips> {
  YesNoAnswer? _selectedValue;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<MedicalFitnessBloc>();

    _selectedValue = bloc.state.data.containsDisease(Diseases.sleepApneaSyndrome)
        ? bloc.state.data.getContainedDisease(Diseases.sleepApneaSyndrome).enable
            ? YesNoAnswer.yes
            : YesNoAnswer.no
        : null;
  }

  void _onSelected(YesNoAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    final bloc = context.read<MedicalFitnessBloc>();

    value == YesNoAnswer.yes
        ? bloc.add(const MedicalFitnessEvent.addDisease(Diseases.sleepApneaSyndrome))
        : bloc.add(const MedicalFitnessEvent.removeDisease(Diseases.sleepApneaSyndrome));

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
          onSelected: _onSelected,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: YesNoAnswer.values.length,
    );
  }
}
