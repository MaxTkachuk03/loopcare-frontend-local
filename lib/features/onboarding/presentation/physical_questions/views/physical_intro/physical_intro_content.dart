import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';

class PhysicalIntroContent extends StatelessWidget {
  const PhysicalIntroContent({super.key});

  void _onNextPressed(BuildContext context) {
    context.read<GeneralOnboardingBloc>()
        ..add(const GeneralOnboardingEvent.start())
        ..add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.yellowDarker(
      body: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Center(
                child: Image(image: AppImages.physicalIntro),
              ),
            ),
            Column(
              children: [
                CustomText.bitter600(
                  LocalizedTexts.physicalIntroTitle.tr(),
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.watch_later_outlined),
                    const SizedBox(width: 10),
                    CustomText.w600(
                      '5 ${LocalizedTexts.minutes.tr()}',
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                CustomText.w400(
                  LocalizedTexts.physicalIntroBody.tr(),
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ],
        ),
      ),
      button: CustomElevatedButton.blueFullWidth(
        label: LocalizedTexts.next.tr(),
        onPressed: () => _onNextPressed(context),
      ),
    );
  }
}
