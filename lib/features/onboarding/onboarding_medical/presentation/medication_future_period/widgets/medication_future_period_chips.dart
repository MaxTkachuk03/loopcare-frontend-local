import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/domain/medication_future_period_answer.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class MedicationFuturePeriodChips extends StatefulWidget {
  const MedicationFuturePeriodChips({super.key});

  @override
  State<MedicationFuturePeriodChips> createState() => _MedicationFuturePeriodChipsState();
}

class _MedicationFuturePeriodChipsState extends State<MedicationFuturePeriodChips> {
  MedicationFuturePeriodAnswer? _selectedValue;

  @override
  void initState() {
    final bloc = context.read<MedicalFitnessBloc>();

    _selectedValue = bloc.state.data.howLongSemaglutideTreatmentLast;

    super.initState();
  }

  void _onSelectedHandler(MedicationFuturePeriodAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    final bloc = context.read<MedicalFitnessBloc>();

    bloc.add(MedicalFitnessEvent.howLongSemaglutideTreatmentLast(value));

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userSemaglutideTreatmentSupposedLength,
      parameters: {
        CustomDefinitions.value: value.name,
      },
    );

    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = MedicationFuturePeriodAnswer.values[i];

        return CustomChoiceChip.coral(
          label: item.label,
          selected: item == _selectedValue,
          onSelected: _onSelectedHandler,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: MedicationFuturePeriodAnswer.values.length,
    );
  }
}
