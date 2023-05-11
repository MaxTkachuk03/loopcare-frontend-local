import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class SexChips extends StatefulWidget {
  const SexChips({Key? key}) : super(key: key);

  @override
  State<SexChips> createState() => _SexChipsState();
}

class _SexChipsState extends State<SexChips> {
  SexType? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<PhysicalFitnessBloc>();

    _selectedValue = bloc.state.sexType;

    super.initState();
  }

  void _onSelectedSexHandler(SexType sex) {
    setState(() {
      _selectedValue = sex;
    });

    final bloc = context.read<PhysicalFitnessBloc>();
    final medicalBloc = context.read<MedicalFitnessBloc>();

    bloc.add(PhysicalFitnessEvent.sexChanged(sex));
    medicalBloc.add(MedicalFitnessEvent.handleSexType(sex));

    if (_selectedValue == SexType.intersex) {
      context.router.pushNamed(AppRoutes.biologicalGender);

      return;
    }

    final physicalFitnessNavigationState = StepNavigationState.of(context);
    physicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: SexType.values
          .map(
            (SexType sex) => Column(
              children: [
                AppChoiceChip(
                  label: sex.name.capitalize(),
                  selected: sex == _selectedValue,
                  value: sex,
                  onSelected: _onSelectedSexHandler,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }
}
