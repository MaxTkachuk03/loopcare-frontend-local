import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/birthday/widgets/birthday_field.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class BirthdayPage extends StatelessWidget {
  const BirthdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: SafeArea(
        bottom: false,
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProgressBar.blue(backgroundColor: AppColors.yellowRegular),
              MainContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 45),
                    CustomText.bitter600(
                      LocalizedTexts.yourBirthday.tr(),
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              const BirthdayField(),
            ],
          ),
        ),
      ),
    );
  }
}
