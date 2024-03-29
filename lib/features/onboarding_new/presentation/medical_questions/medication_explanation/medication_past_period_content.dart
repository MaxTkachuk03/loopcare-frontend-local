import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';

class MedicationExplanationContent extends StatelessWidget {
  const MedicationExplanationContent({super.key});

  void _onNextPressed(BuildContext context) {
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.blue(
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          UnderAppbar.blue(
            height: 100,
            child: const SizedBox.shrink(),
          ),
          const SizedBox(height: 20),
          MainContainer(
            child: CustomText.bitter600(
              LocalizedTexts.medicationExplanationTitle.tr(),
              style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          MainContainer(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: const BoxDecoration(
                color: AppColors.blueLightest,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: RichText(
                text: TextSpan(
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody1.tr(),
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody2.tr(),
                    ),
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody3.tr(),
                      style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody4.tr(),
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody5.tr(),
                    ),
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody6.tr(),
                      style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody7.tr(),
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody8.tr(),
                    ),
                    TextSpan(
                      text: LocalizedTexts.medicationExplanationBody9.tr(),
                      style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
      button: CustomElevatedButton.coralFullWidth(
        label: LocalizedTexts.next.tr(),
        onPressed: () => _onNextPressed(context),
      ),
    );
  }
}
