import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/emergency_btn.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class FinalResultsText extends StatelessWidget {
  final Function onLinkPressed;

  const FinalResultsText({super.key, required this.onLinkPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MentalQuestionsBloc, MentalQuestionsState>(
      builder: (context, state) {
        final gad7Result = state.results[MentalHealthTestType.gad7]?.interpretation;
        final phq8Result = state.results[MentalHealthTestType.phq8]?.interpretation;
        final phq15Result = state.results[MentalHealthTestType.phq15]?.interpretation;

        final phq8IsHigh = phq8Result == InterpretationType.high;

        if (phq8IsHigh) {
          return Column(
            children: [
              CustomText.w400(
                LocalizedTexts.onboardingPhq8FinalResultHigh1.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingPhq8FinalResultHigh2.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingPhq8FinalResultHigh3.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.blueAppBar),
                  text: LocalizedTexts.linksPsychologistConsulting.tr(),
                  recognizer: TapGestureRecognizer()..onTap = () => onLinkPressed(context),
                ),
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingPhq8FinalResultHigh4.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingIfYouHaveSuicidalThoughts.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              const EmergencyBtn()
            ],
          );
        }

        final phq15IsHigh = phq15Result == InterpretationType.high;
        final gad7IsHigh = gad7Result == InterpretationType.high;

        if (phq15IsHigh && gad7IsHigh) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w400(
                LocalizedTexts.onboardingPersonalProgram.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingFeelLimited1.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingNotATherapy.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingLearnManyThings.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingUnlockAllSections.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingAwailableAreas.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText.w400(
                  LocalizedTexts.nutrition.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText.w400(
                  LocalizedTexts.exercise.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText.w400(
                  LocalizedTexts.onboardingMentalHealth.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText.w400(
                  LocalizedTexts.onboardingUnlockBuddyMessage.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingWeWillGuideYou.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ],
          );
        }

        if (phq15IsHigh) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w400(
                LocalizedTexts.onboardingPersonalProgram.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingFeelLimited2.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingNotATherapy.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingLearnManyThings.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingUnlockAllSections.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingAwailableAreas.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText.w400(
                  LocalizedTexts.nutrition.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText.w400(
                  LocalizedTexts.exercise.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText.w400(
                  LocalizedTexts.onboardingMentalHealth.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText.w400(
                  LocalizedTexts.onboardingUnlockBuddyMessage.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              CustomText.w400(
                LocalizedTexts.onboardingWeWillGuideYou.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ],
          );
        }

        if (gad7IsHigh) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w400(
                LocalizedTexts.onboardingPersonalProgram.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingFeelLimited3.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingNotATherapy.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingLearnManyThings.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingUnlockAllSections.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingAwailableAreas.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText(
                  LocalizedTexts.nutrition.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText(
                  LocalizedTexts.exercise.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText(
                  LocalizedTexts.onboardingMentalHealth.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText(
                  LocalizedTexts.onboardingUnlockBuddyMessage.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingWeWillGuideYou.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ],
          );
        }

        final phq15IsModerate = phq15Result == InterpretationType.moderate;
        final gad7IsModerate = gad7Result == InterpretationType.moderate;
        final phq8IsModerate = phq8Result == InterpretationType.moderate;

        if (phq15IsModerate && gad7IsModerate && phq8IsModerate) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w400(
                LocalizedTexts.onboardingSupportMessage.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingFeelLimited4.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingNotATherapy.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingLearnManyThings.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingUnlockAllSections.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingAwailableAreas.tr(),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText(
                  LocalizedTexts.nutrition.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText(
                  LocalizedTexts.exercise.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText(
                  LocalizedTexts.onboardingMentalHealth.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              BulletListItem(
                bulletSize: 14.0,
                text: CustomText(
                  LocalizedTexts.onboardingUnlockBuddyMessage.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              CustomText(
                LocalizedTexts.onboardingWeWillGuideYou.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText.w400(
              LocalizedTexts.onboardingPersonalProgram.tr(),
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            CustomText(
              LocalizedTexts.onboardingUnlockAllSections.tr(),
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            CustomText(
              LocalizedTexts.onboardingAwailableAreas.tr(),
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            BulletListItem(
              bulletSize: 14.0,
              text: CustomText(
                LocalizedTexts.nutrition.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ),
            BulletListItem(
              bulletSize: 14.0,
              text: CustomText(
                LocalizedTexts.exercise.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ),
            BulletListItem(
              bulletSize: 14.0,
              text: CustomText(
                LocalizedTexts.onboardingMentalHealth.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ),
            BulletListItem(
              bulletSize: 14.0,
              text: CustomText(
                LocalizedTexts.onboardingUnlockBuddyMessage.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
              LocalizedTexts.onboardingWeWillGuideYou.tr(),
              style: context.textTheme.bodyMedium,
            ),
          ],
        );
      },
    );
  }
}
