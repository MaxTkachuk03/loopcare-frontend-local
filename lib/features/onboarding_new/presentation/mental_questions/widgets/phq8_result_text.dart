import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/mental_health_answer/test_result.dart';

class PHQ8ResultText extends StatelessWidget {
  final Function onLinkPressed;

  const PHQ8ResultText({super.key, required this.onLinkPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalQuestionsBloc, MentalQuestionsState>(
      builder: (context, state) {
        final generalBloc = context.read<GeneralOnboardingBloc>();

        final currentTestType = generalBloc.state.currentMentalTest!.type;

        final currentResult = state.results[currentTestType];

        return _getTextWidget(context, currentResult);
      },
    );
  }

  Widget _getTextWidget(BuildContext context, TestResult? testResult) {
    switch (testResult?.interpretation) {
      case InterpretationType.minimal:
        return Text(LocalizedTexts.phq8ResultMinimal.tr(), style: context.textTheme.bodyMedium);
      case InterpretationType.mild:
        return Text(LocalizedTexts.phq8ResultMild.tr(), style: context.textTheme.bodyMedium);
      case InterpretationType.moderate:
        return Text(LocalizedTexts.phq8ResultMedium.tr(), style: context.textTheme.bodyMedium);
      case InterpretationType.high:
        final totalScore = testResult?.totalScore;
        if (totalScore == null) return const SizedBox.shrink();

        final text =
            totalScore > 19 ? LocalizedTexts.phq8ResultHighest.tr() : LocalizedTexts.phq8ResultHigh.tr();

        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text,
                style: context.textTheme.bodyMedium,
              ),
              TextSpan(
                style: context.textTheme.bodyMedium?.copyWith(color: AppColors.blueAppBar),
                text: '\n$psychologistConsultingLink \n\n',
                recognizer: TapGestureRecognizer()..onTap = () => onLinkPressed(context),
              ),
              TextSpan(
                text: LocalizedTexts.ifYouHaveSuicidalThoughts.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
