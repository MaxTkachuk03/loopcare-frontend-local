import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/interpretation_type.dart';

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

        return switch (interpretation) {
          InterpretationType.minimal =>  CustomText.w400(
            LocalizedTexts.gad7ResultMinimal.tr(),
            style: context.textTheme.bodyMedium,
          ),
          InterpretationType.mild => CustomText.w400(
            LocalizedTexts.gad7ResultMild.tr(),
            style: context.textTheme.bodyMedium,
          ),
          InterpretationType.moderate => CustomText.w400(
            LocalizedTexts.gad7ResultMedium.tr(),
            style: context.textTheme.bodyMedium,
          ),
          InterpretationType.high => RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${LocalizedTexts.gad7ResultHigh.tr()} \n',
                  style: context.textTheme.bodyMedium,
                ),
                TextSpan(
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.blueAppBar),
                  text: '${LocalizedTexts.linksPsychologistConsulting.tr()} \n\n',
                  recognizer: TapGestureRecognizer()..onTap = () => onLinkPressed(context),
                ),
                TextSpan(
                  text: LocalizedTexts.mentalTestResultsIfYouHaveSuicidalThoughts.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
