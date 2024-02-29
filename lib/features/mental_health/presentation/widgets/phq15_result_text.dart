import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';

class PHQ15ResultText extends StatelessWidget {
  final Function onLinkPressed;

  const PHQ15ResultText({super.key, required this.onLinkPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalHealthBloc, MentalHealthState>(
      builder: (context, state) {
        final currentTestType = state.data.currentTest?.type;

        if (currentTestType == null) return const SizedBox.shrink();

        final currentResult = state.data.results[currentTestType];
        final interpretation = currentResult?.interpretation;

        final isHigh = interpretation == InterpretationType.high;

        AnalyticsEventService.instance.logEvent(
          FirebaseEvents.userMentalHealthTest,
          parameters: {
            CustomDefinitions.testType: currentTestType.name,
            CustomDefinitions.itemInterpretation: interpretation?.name ?? '',
            CustomDefinitions.totalScore: currentResult?.totalScore ?? '',
            if (interpretation != InterpretationType.high) CustomDefinitions.exclusion: 'false'
          },
        );

        return RichText(
          text: TextSpan(children: [
            TextSpan(
              text: _getText(interpretation),
              style: context.textTheme.bodyMedium,
            ),
            if (isHigh)
              TextSpan(
                style: context.textTheme.bodyMedium?.copyWith(color: AppColors.blueAppBar),
                text: '\n$psychologistConsultingLink \n\n',
                recognizer: TapGestureRecognizer()..onTap = () => onLinkPressed(context),
              ),
            if (isHigh)
              TextSpan(
                text: LocalizedTexts.ifYouHaveSuicidalThoughts.tr(),
                style: context.textTheme.bodyMedium,
              ),
          ]),
        );
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
