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
import 'package:loopcare_frontend/core/presentation/widgets/survey_image_clipper.dart';

class CheckFailedAgePage extends StatelessWidget {
  const CheckFailedAgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.yellow(
      appBar: CustomAppBar.yellow(
        title: LocalizedTexts.physicalIntroTitle.tr(),
        leading: CustomFilledIconButton.leadingYellowLighter(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            children: [
              ClipPath(
                clipper: SurveyImageClipper2(),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  color: AppColors.yellowRegular,
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
              ),
              const SizedBox(height: 48),
              MainContainer(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: CustomText.w400(
                    LocalizedTexts.ageCheckFailedBody.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
