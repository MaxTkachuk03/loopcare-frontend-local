import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class FailedBmiBody extends StatelessWidget {
  const FailedBmiBody({
    super.key,
    required this.bmi,
  });

  final num bmi;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.w400(
          LocalizedTexts.onboardingBmiExclusionBodyTitle.tr(),
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10.0),
        CustomText.w600(
          bmi.toStringAsFixed(1),
          style: context.textTheme.headlineLarge,
        ),
        const SizedBox(height: 10.0),
        CustomText.w400(
          LocalizedTexts.onboardingBmiExclusionBody1.tr(),
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20.0),
        CustomText.w400(
          LocalizedTexts.onboardingBmiExclusionBody2.tr(),
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
