import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/sex/widgets/sex_chips.dart';

class SexPage extends StatelessWidget {
  const SexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: SafeArea(
        child: ScrollableContainer(
          child: Column(
            children: [
              ProgressBar.blue(backgroundColor: AppColors.yellowRegular),
              MainContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    CustomText.bitter600(
                      LocalizedTexts.yourSex.tr(),
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 36),
                    const SexChips(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
