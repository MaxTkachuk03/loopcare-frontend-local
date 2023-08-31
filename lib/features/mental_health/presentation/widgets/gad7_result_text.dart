import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_check_result_page.dart';

class GAD7ResultText extends StatelessWidget {
  const GAD7ResultText({Key? key}) : super(key: key);

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
        );
      },
    );
  }

  String _getText(InterpretationType? interpretation) {
    switch (interpretation) {
      case InterpretationType.minimal:
        return LocalizedTexts.gad7ResultMinimal.translation;
      case InterpretationType.mild:
        return LocalizedTexts.gad7ResultMild.translation;
      case InterpretationType.moderate:
        return LocalizedTexts.gad7ResultMedium.translation;
      case InterpretationType.high:
        return '${LocalizedTexts.gad7ResultHigh.translation} $psychologistConsultingLink \n${LocalizedTexts.ifYouHaveSuicidalThoughts.translation}';
      default:
        return '';
    }
  }
}
