import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

class FailedAgeContent extends StatelessWidget {
  const FailedAgeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UnderAppbar.yellow(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65.0),
              child: CustomText.bitter600(
                LocalizedTexts.ageCheckFailedTitle.tr(),
                style: context.textTheme.displayMedium,
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
              color: AppColors.yellowLightest,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: CustomText.w400(
              LocalizedTexts.ageCheckFailedBody.tr(),
              style: context.textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
