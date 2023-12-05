import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class MedicalIntroPage extends StatelessWidget {
  const MedicalIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      onWillPop: () => _onWillPop(context),
      child: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 80.0,
                ),
                Text(
                  LocalizedTexts.checkYourMedicalCondition.tr(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: ThemeConstants.bitterFontFamily,
                      ),
                ),
                const SizedBox(
                  height: 21.0,
                ),
                Text(
                  LocalizedTexts.medicalIntroTitle.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                BulletListItem(
                  bulletSize: 18.0,
                  text: Text(
                    LocalizedTexts.medicalIntroInstructionFirst.tr(),
                    style: const TextStyle(
                      fontSize: ThemeConstants.fontSize18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                BulletListItem(
                  bulletSize: 18.0,
                  text: Text(
                    LocalizedTexts.medicalIntroInstructionSecond.tr(),
                    style: const TextStyle(
                      fontSize: ThemeConstants.fontSize18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                BulletListItem(
                  bulletSize: 18.0,
                  text: Text(
                    LocalizedTexts.medicalIntroInstructionThird.tr(),
                    style: const TextStyle(
                      fontSize: ThemeConstants.fontSize18,
                    ),
                  ),
                ),
              ],
            ),
            const Column(
              children: [
                _NextButton(),
                SizedBox(
                  height: 24.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onWillPop(BuildContext context) {
    context.read<OnboardingBloc>().add(const OnboardingEvent.previousStep());
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final medicalFitnessNavigationState = StepNavigationState.of(context);

    return ElevatedButton(
      onPressed: medicalFitnessNavigationState.onNextPage,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
          ),
      child: Text(LocalizedTexts.next.tr()),
    );
  }
}
