import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/biological_gender/widgets/biological_gender_chips.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class BiologicalGenderPage extends StatelessWidget {
  const BiologicalGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      isWithOnWillPop: false,
      child: CustomScaffold.yellowLightest(
        appBar: CustomAppBar.yellow(
          title: LocalizedTexts.physicalIntroTitle.tr(),
          leading: CustomFilledIconButton.leadingYellowLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              children: [
                ProgressBar.blue(backgroundColor: AppColors.yellowRegular),
                MainContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      CustomText.bitter600(
                        '${LocalizedTexts.genderPageTitle.tr()}?',
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 36),
                      const BiologicalGenderChips(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _onWhyWeAreAskingPressed() {}
}
