import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class MedicalCheckPassedContent extends StatelessWidget {
  const MedicalCheckPassedContent({super.key});

  void _onNextPressed(BuildContext context) {
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.coral(
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          UnderAppbar.coral(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 22.0,
                      backgroundColor: AppColors.white,
                      child: Icon(Icons.check, size: 24, color: AppColors.blueDarker),
                    ),
                    const SizedBox(height: 22.0),
                    CustomText.bitter600(
                      LocalizedTexts.onboardingMedicalCheckPassedTitle.tr(),
                      style: context.textTheme.displayMedium?.copyWith(color: AppColors.blueDarker),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          MainContainer(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: const BoxDecoration(
                color: AppColors.coralLightest,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: CustomText.w600(
                LocalizedTexts.onboardingMedicalCheckPassedBody.tr(),
                style: context.textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
      button: CustomElevatedButton.blueFullWidth(
        onPressed: () => _onNextPressed(context),
        label: LocalizedTexts.next.tr(),
      ),
    );
  }
}
