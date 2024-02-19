import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/domain/medication_past_period_answer.dart';

class MedicationPastPeriodChips extends StatefulWidget {
  const MedicationPastPeriodChips({super.key});

  @override
  State<MedicationPastPeriodChips> createState() => _MedicationPastPeriodChipsState();
}

class _MedicationPastPeriodChipsState extends State<MedicationPastPeriodChips> {
  MedicationPastPeriodAnswer? _selectedValue;

  void _onSelectedMedicationPastPeriodHandler(MedicationPastPeriodAnswer value) {
    setState(() {
      _selectedValue = value;
    });

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userLengthSemaglutideIntake,
      parameters: {
        CustomDefinitions.value: value.name,
      },
    );

// TODO: No need save value to block/backend?
    context.router.pushNamed(AppRoutes.medicationFuturePeriod);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = MedicationPastPeriodAnswer.values[i];

        return CustomChoiceChip.coral(
          label: item.label,
          selected: item == _selectedValue,
          onSelected: _onSelectedMedicationPastPeriodHandler,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: MedicationPastPeriodAnswer.values.length,
    );
  }
}
