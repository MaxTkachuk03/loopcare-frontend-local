import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

class PregnancyFailedContent extends StatelessWidget {
  const PregnancyFailedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        UnderAppbar.coral(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65.0),
              child: CustomText.bitter600(
                LocalizedTexts.failedPregnancyTitle.tr(),
                style: context.textTheme.displayMedium?.copyWith(color: AppColors.blueDarker),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        MainContainer(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: const BoxDecoration(
              color: AppColors.coralLightest,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText.w600(
                  LocalizedTexts.failedPregnancyBody1.tr(),
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20.0),
                CustomText.w400(
                  LocalizedTexts.failedPregnancyBody2.tr(),
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20.0),
                CustomText.w400(
                  LocalizedTexts.failedPregnancyBody3.tr(),
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20.0),
                CustomText.w400(
                  LocalizedTexts.failedPregnancyBody4.tr(),
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
