import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class PregnancyChips extends StatefulWidget {
  const PregnancyChips({super.key});

  @override
  State<PregnancyChips> createState() => _PregnancyChipsState();
}

class _PregnancyChipsState extends State<PregnancyChips> {
  YesNoAnswer? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<MedicalFitnessBloc>();
    _selectedValue = bloc.state.data.pregnancy;

    super.initState();
  }

  void _onSelectedPregnancyHandler(YesNoAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userPregnancy,
      parameters: {
        CustomDefinitions.value: value.name,
      },
    );

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
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = YesNoAnswer.values[i];

        return CustomChoiceChip.coral(
          label: item.name.capitalize(),
          selected: item == _selectedValue,
          onSelected: _onSelectedPregnancyHandler,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: YesNoAnswer.values.length,
    );
  }
}
