import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/bmi_calculator.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/bmi_validator.dart';

class CheckFailedBmiPage extends StatelessWidget {
  const CheckFailedBmiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.yellow(
      appBar: CustomAppBar.yellow(
        title: LocalizedTexts.bodyAndMind.tr(),
        leading: CustomFilledIconButton.leadingYellowLighter(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            children: [
              UnderAppbar.yellow(
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
              const SizedBox(height: 48),
              MainContainer(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.w400(
                        '${LocalizedTexts.yourBodyMassIndex.tr()}:',
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10.0),
                      BlocBuilder<PhysicalFitnessBloc, PhysicalFitnessState>(
                        builder: (BuildContext context, state) {
                          final bmiIndex = BmiCalculator.getUserBmiIndex(state.heightInCm, state.weightInKg);

                          return CustomText.w600('$bmiIndex', style: context.textTheme.headlineLarge);
                        },
                      ),
                      const SizedBox(height: 10.0),
                      BlocBuilder<PhysicalFitnessBloc, PhysicalFitnessState>(
                        builder: (BuildContext context, state) {
                          final bmiMaxValue = BmiValidator.getMaxBmiIndexValue(state.age ?? 0);
                          final bmiMinValue = BmiValidator.getMinBmiIndexValue();

                          return CustomText.w400(
                            LocalizedTexts.fitnessCheckFailedInformationText.tr(
                              namedArgs: {'bmiMaxIndex': bmiMaxValue, 'bmiMinIndex': bmiMinValue},
                            ),
                            style: context.textTheme.bodyMedium,
                          );
                        },
                      ),
                      const SizedBox(height: 26),
                      CustomText.w400(
                        LocalizedTexts.fitnessCheckFailedInformationText2,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
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
