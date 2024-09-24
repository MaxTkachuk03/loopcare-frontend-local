import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/onboarding/utils/bmi_calculator.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class BMIDescription extends StatelessWidget {
  const BMIDescription({super.key, required this.bmi});

  final num bmi;

  @override
  Widget build(BuildContext context) {
    if (bmi > BmiCalculator.upperAcceptableValue) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText.w400(
            LocalizedTexts.onboardingHighBmiDescription1.tr(),
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: LocalizedTexts.onboardingHighBmiDescription2.tr(),
                  style: context.textTheme.bodyMedium,
                ),
                TextSpan(
                  text: LocalizedTexts.onboardingHighBmiDescription3.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (bmi > BmiCalculator.lowerAcceptableValue) {
      return CustomText.w400(
        LocalizedTexts.onboardingBmiDescription2.tr(),
        style: context.textTheme.bodyMedium,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText.w400(
            LocalizedTexts.onboardingLowerBmiDescription1.tr(),
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          CustomText.w400(
            LocalizedTexts.onboardingLowerBmiDescription2.tr(),
            style: context.textTheme.bodyMedium,
          ),
        ],
      );
    }
  }
}
