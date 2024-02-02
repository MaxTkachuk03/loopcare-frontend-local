import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class MedicalIntroPage extends StatelessWidget {
  const MedicalIntroPage({super.key});

  void _onWillPop(BuildContext context) {
    context.read<OnboardingBloc>().add(const OnboardingEvent.previousStep());
  }

  void _onPressedHandler(BuildContext context) {
    StepNavigationState.of(context).onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      onWillPop: () => _onWillPop(context),
      child: CustomScaffold.blue(
        appBar: CustomAppBar.transparent(leading: CustomFilledIconButton.leadingBlueLighter()),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Container(
                          alignment: Alignment.center, child: const Image(image: AppImages.medicalIntro)),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText.bitter600(
                        LocalizedTexts.medicalIntroTitle.tr(),
                        style: context.textTheme.displayLarge?.copyWith(color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.watch_later_outlined, color: AppColors.white),
                          const SizedBox(width: 10),
                          CustomText.w600(
                            '15 ${LocalizedTexts.minutes.tr()}',
                            style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      CustomText.w400(
                        '${LocalizedTexts.medicalIntroBody.tr()}.',
                        style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      Builder(
                        builder: (context) => CustomElevatedButton.coralFullWidth(
                          label: LocalizedTexts.next.tr(),
                          onPressed: () => _onPressedHandler(context),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
