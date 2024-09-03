import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';

class MentalHealthPreIntroContent extends StatelessWidget {
  const MentalHealthPreIntroContent({super.key});

  void _onPressedHandler(BuildContext context) {
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.petrolDarker(
      body: MainContainer(
        child: ScrollableContainer(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Image(image: AppImages.mentalIntro),
              ),
              Column(
                children: [
                  const SizedBox(height: 20.0),
                  CustomText.bitter600(
                    LocalizedTexts.mentalHealth.tr(),
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
                    '${LocalizedTexts.mentalIntroBody1.tr()}.',
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  CustomText.w400(
                    '${LocalizedTexts.mentalIntroBody2.tr()}.',
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
      button: CustomElevatedButton.blueFullWidth(
        label: LocalizedTexts.next.tr(),
        onPressed: () => _onPressedHandler(context),
      ),
    );
  }
}
