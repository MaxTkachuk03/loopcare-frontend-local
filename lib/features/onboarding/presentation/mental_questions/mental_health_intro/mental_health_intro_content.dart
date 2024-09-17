import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_with_accents/text_with_accents.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class MentalHealthIntroContent extends StatelessWidget {
  const MentalHealthIntroContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.petrolLightest(
      body: MainContainer(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 24.0),
            CustomText.bitter600(
              LocalizedTexts.onboardingYourMentalHealth.tr(),
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 28.0),
            CustomText.w600(
              LocalizedTexts.onboardingMentalHealthIntroTextOne.tr(),
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20.0),
            TextWithAccents(
              LocalizedTexts.onboardingMentalHealthIntroTextTwo.tr(),
              accents: [LocalizedTexts.onboardingMentalHealthIntroTextTwoAccent.tr()],
            ),
            const SizedBox(height: 20.0),
            TextWithAccents(
              LocalizedTexts.onboardingMentalHealthIntroTextThree.tr(),
              accents: [LocalizedTexts.onboardingMentalHealthIntroTextThreeAccent.tr()],
            ),
            const SizedBox(height: 20.0),
            CustomText.w400(
              LocalizedTexts.onboardingMentalHealthIntroTextFour.tr(),
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20.0),
            CustomText.w400(
              LocalizedTexts.onboardingMentalHealthIntroTextFive.tr(),
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20.0),
            CustomText.w400(
              LocalizedTexts.onboardingMentalHealthIntroTextSix.tr(),
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 40.0),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomOutlinedButton.petrolSmall(
                label: LocalizedTexts.moreInfo.tr(),
                onPressed: () => _onMoreInfoPressed(context),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      button: CustomElevatedButton.blueFullWidth(
        onPressed: () => _onNextPressed(context),
        label: LocalizedTexts.next.tr(),
      ),
    );
  }

  _onNextPressed(BuildContext context) {
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.startTimer());
  }

  _onMoreInfoPressed(BuildContext context) =>
      ModalBottomSheet.mentalHealthMoreInfo(context: context);
}
