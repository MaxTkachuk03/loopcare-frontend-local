import 'package:easy_localization/easy_localization.dart';
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
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';

class MedicalIntroContent extends StatelessWidget {
  const MedicalIntroContent({super.key});

  void _onPressedNext(BuildContext context) {
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.blueDarker(
      body: ScrollableContainer(
        physics: const ClampingScrollPhysics(),
        child: MainContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  alignment: Alignment.center,
                  child: const Image(image: AppImages.medicalIntro),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20.0),
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
                  const SizedBox(height: 40.0),
                ],
              ),
            ],
          ),
        ),
      ),
      button: CustomElevatedButton.coralFullWidth(
        label: LocalizedTexts.next.tr(),
        onPressed: () => _onPressedNext(context),
      ),
    );
  }
}
