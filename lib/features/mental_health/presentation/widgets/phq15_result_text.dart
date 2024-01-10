import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';

class PHQ15ResultText extends StatelessWidget {
  const PHQ15ResultText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalHealthBloc, MentalHealthState>(
      builder: (context, state) {
        final currentTestType = state.data.currentTest?.type;

        if (currentTestType == null) return const SizedBox.shrink();

        final interpretation = state.data.results[currentTestType]?.interpretation;

        return CustomText.w400(_getText(interpretation), style: context.textTheme.bodyMedium);
      },
    );
  }

  String _getText(InterpretationType? interpretation) {
    switch (interpretation) {
      case InterpretationType.minimal:
        return LocalizedTexts.phq15ResultMinimal.tr();
      case InterpretationType.mild:
        return LocalizedTexts.phq15ResultMild.tr();
      case InterpretationType.moderate:
        return LocalizedTexts.phq15ResultMedium.tr();
      case InterpretationType.high:
        return LocalizedTexts.phq15ResultHigh.tr();
      default:
        return '';
    }
  }
}
