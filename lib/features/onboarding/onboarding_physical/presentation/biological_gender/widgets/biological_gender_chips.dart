import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/biological_gender_type.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/reg_exp_utils.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class BiologicalGenderChips extends StatefulWidget {
  const BiologicalGenderChips({super.key});

  @override
  State<BiologicalGenderChips> createState() => _BiologicalGenderChipsState();
}

class _BiologicalGenderChipsState extends State<BiologicalGenderChips> {
  BiologicalGenderType? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<PhysicalFitnessBloc>();

    _selectedValue = bloc.state.biologicalGenderType;

    super.initState();
  }

  void _onSelectedBiologicalGenderHandler(BiologicalGenderType gender) {
    setState(() {
      _selectedValue = gender;
    });

    final bloc = context.read<PhysicalFitnessBloc>();

    bloc.add(PhysicalFitnessEvent.biologicalGenderChanged(gender));

    final physicalFitnessNavigationState = StepNavigationState.of(context);

    physicalFitnessNavigationState.onNextPage();
  }

  String _getLabelText(String str) {
    return str.split(RegExp(RegExpUtils.upperCaseLetters)).join(' ').capitalize();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = BiologicalGenderType.values[i];

        return CustomChoiceChip.yellow(
          label: _getLabelText(item.name),
          selected: item == _selectedValue,
          onSelected: _onSelectedBiologicalGenderHandler,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: BiologicalGenderType.values.length,
    );
  }
}
