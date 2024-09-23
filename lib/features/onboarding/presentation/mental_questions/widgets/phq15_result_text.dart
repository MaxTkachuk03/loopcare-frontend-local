import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/interpretation_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class PHQ15ResultText extends StatelessWidget {
  final Function onLinkPressed;

  const PHQ15ResultText({super.key, required this.onLinkPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalQuestionsBloc, MentalQuestionsState>(
      builder: (context, state) {
        final generalBloc = context.read<GeneralOnboardingBloc>();

        final currentTestType = generalBloc.state.currentMentalTest!.type;

        final currentResult = state.results[currentTestType];
        final interpretation = currentResult?.interpretation;

        final isHigh = interpretation == InterpretationType.high;

        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: _getText(interpretation),
                style: context.textTheme.bodyMedium,
              ),
              if (isHigh) ...[
                TextSpan(
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.blueAppBar),
                  text: '\n${LocalizedTexts.linksPsychologistConsulting.tr()} \n\n',
                  recognizer: TapGestureRecognizer()..onTap = () => onLinkPressed(context),
                ),
                TextSpan(
                  text: LocalizedTexts.onboardingIfYouHaveSuicidalThoughts.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  String _getText(InterpretationType? interpretation) => switch (interpretation) {
        InterpretationType.minimal => LocalizedTexts.onboardingPhq15ResultMinimal.tr(),
        InterpretationType.mild => LocalizedTexts.onboardingPhq15ResultMild.tr(),
        InterpretationType.moderate => LocalizedTexts.onboardingPhq15ResultMedium.tr(),
        InterpretationType.high => LocalizedTexts.onboardingPhq15ResultHigh.tr(),
        _ => '',
      };
}
