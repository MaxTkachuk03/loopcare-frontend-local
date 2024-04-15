import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/interpretation_type.dart';

class GAD7ResultText extends StatelessWidget {
  final Function onLinkPressed;

  const GAD7ResultText({super.key, required this.onLinkPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalQuestionsBloc, MentalQuestionsState>(
      builder: (context, state) {
        final generalBloc = context.read<GeneralOnboardingBloc>();

        final currentTestType = generalBloc.state.currentMentalTest!.type;

        final currentResult = state.results[currentTestType];
        final interpretation = currentResult?.interpretation;

        AnalyticsEventService.instance.logEvent(
          FirebaseEvents.userMentalHealthTest,
          parameters: {
            CustomDefinitions.testType: currentTestType.name,
            CustomDefinitions.itemInterpretation: interpretation?.name ?? '',
            CustomDefinitions.totalScore: currentResult?.totalScore ?? '',
          },
        );

        return _getTextWidget(context, interpretation);
      },
    );
  }

  Widget _getTextWidget(BuildContext context, InterpretationType? interpretation) {
    switch (interpretation) {
      case InterpretationType.minimal:
        return CustomText.w400(LocalizedTexts.gad7ResultMinimal.tr(), style: context.textTheme.bodyMedium);
      case InterpretationType.mild:
        return CustomText.w400(LocalizedTexts.gad7ResultMild.tr(), style: context.textTheme.bodyMedium);
      case InterpretationType.moderate:
        return CustomText.w400(LocalizedTexts.gad7ResultMedium.tr(), style: context.textTheme.bodyMedium);
      case InterpretationType.high:
        return RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '${LocalizedTexts.gad7ResultHigh.tr()} \n',
              style: context.textTheme.bodyMedium,
            ),
            TextSpan(
              style: context.textTheme.bodyMedium?.copyWith(color: AppColors.blueAppBar),
              text: '$psychologistConsultingLink \n\n',
              recognizer: TapGestureRecognizer()..onTap = () => onLinkPressed(context),
            ),
            TextSpan(
              text: LocalizedTexts.ifYouHaveSuicidalThoughts.tr(),
              style: context.textTheme.bodyMedium,
            ),
          ]),
        );

      default:
        return const Text('');
    }
  }
}
