import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';

class PHQ15ResultText extends StatelessWidget {
  const PHQ15ResultText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalHealthBloc, MentalHealthState>(
      builder: (context, state) {
        final currentTestType = state.data.currentTest?.type;

        if (currentTestType == null) return const SizedBox.shrink();

        final interpretation = state.data.results[currentTestType]?.interpretation;

        return Text(
          _getText(interpretation),
          style: Theme.of(context).textTheme.bodyLarge,
        ).tr();
      },
    );
  }

  String _getText(InterpretationType? interpretation) {
    switch (interpretation) {
      case InterpretationType.minimal:
        return LocalizedTexts.phq15ResultMinimal;
      case InterpretationType.mild:
        return LocalizedTexts.phq15ResultMild;
      case InterpretationType.moderate:
        return LocalizedTexts.phq15ResultMedium;
      case InterpretationType.high:
        return LocalizedTexts.phq15ResultHigh;
      default:
        return '';
    }
  }
}
