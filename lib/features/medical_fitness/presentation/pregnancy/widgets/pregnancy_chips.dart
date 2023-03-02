import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/biological_gender_type.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';

class PregnancyChips extends StatefulWidget {
  const PregnancyChips({Key? key}) : super(key: key);

  @override
  State<PregnancyChips> createState() => _PregnancyChipsState();
}

class _PregnancyChipsState extends State<PregnancyChips> {
  YesNoAnswer? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<MedicalFitnessBloc>();
    _selectedValue = bloc.state.pregnancy;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final bloc = context.read<MedicalFitnessBloc>();
    final physicalBloc = context.read<PhysicalFitnessBloc>();
    bool isfemale = physicalBloc.state.sexType == SexType.female;
    bool tooOldAge = (physicalBloc.state.age ?? 0) >= 60;
    if (!isfemale || tooOldAge) {
      bloc.add(const MedicalFitnessEvent.pregnancyChanged(YesNoAnswer.no));
      final medicalFitnessNavigationState = StepNavigationState.of(context);
      medicalFitnessNavigationState.onNextPage();
    }

    super.didChangeDependencies();
  }

  void _onSelectedPregnancyHandler(YesNoAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    if (value == YesNoAnswer.yes) {
      context.router.pushNamed(AppRoutes.pregnancyFailed);

      return;
    }

    final bloc = context.read<MedicalFitnessBloc>();

    bloc.add(MedicalFitnessEvent.pregnancyChanged(value));

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
