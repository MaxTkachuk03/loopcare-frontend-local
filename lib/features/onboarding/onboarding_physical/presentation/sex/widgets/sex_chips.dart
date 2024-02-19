import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/sex_type.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class SexChips extends StatefulWidget {
  const SexChips({super.key});

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

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userSex,
      parameters: {
        CustomDefinitions.value: sex.name,
      },
    );

    if (_selectedValue == SexType.intersex) {
      context.router.pushNamed(AppRoutes.biologicalGender);

      return;
    }

    final physicalFitnessNavigationState = StepNavigationState.of(context);
    physicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = SexType.values[i];

        return CustomChoiceChip.yellow(
          label: item.name.capitalize(),
          selected: item == _selectedValue,
          onSelected: _onSelectedSexHandler,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: SexType.values.length,
    );
  }
}
