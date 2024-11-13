import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/check_passed/widgets/bmi_description.dart';
import 'package:loopcare_frontend/features/onboarding/utils/height_conversion_utils.dart';
import 'package:loopcare_frontend/features/onboarding/utils/weight_conversion_utils.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class CheckPassedContent extends StatelessWidget {
  const CheckPassedContent({super.key});

  String _getHeightValue(bool useMetric, String heightInCm) {
    final int heightFt =
        HeightConversionUtils.doubleConvertCMtoFT(double.parse(heightInCm)).round();

    final int heightInches =
        HeightConversionUtils.doubleConvertCMtoFtIn(double.parse(heightInCm)).round();
    final int intHeightInCm = double.parse(heightInCm).round();

    final heightValue = useMetric ? '$intHeightInCm cm' : '$heightFt ft $heightInches in';

    return heightValue;
  }

  String _getWeightValue(bool useMetric, String weightInKg) {
    final weightLbs = WeightConversionUtils.convertKgToLbs(double.parse(weightInKg));

    return useMetric ? '$weightInKg kg' : '$weightLbs lbs';
  }

  void _onContinuePressed(BuildContext context) {
    final state = context.read<PhysicalQuestionsBloc>().state;
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
    context
        .read<GeneralOnboardingBloc>()
        .add(GeneralOnboardingEvent.excludeMentalQuestionsByGender(sex: state.sexType!));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<PhysicalQuestionsBloc>().state;
    final isHeightMetric = state.heightMeasurementSystemType.isMetric;
    final isWeightMetric = state.weightMeasurementSystemType.isMetric;
    final heightValue = _getHeightValue(isHeightMetric, state.heightInCm ?? '');
    final weightValue = _getWeightValue(isWeightMetric, state.weightInKg ?? '');
    final bmi = state.bmi ?? 0;

    return BottomPlacedButton.yellow(
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          UnderAppbar.yellow(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 22.0,
                      backgroundColor: AppColors.blueDarker,
                      child: Icon(Icons.check, size: 24),
                    ),
                    const SizedBox(height: 22.0),
                    CustomText.bitter600(
                      LocalizedTexts.onboardingPhysicalCheckPassedTitle.tr(),
                      style: context.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          MainContainer(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: const BoxDecoration(
                    color: AppColors.yellowLightest,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.w400(LocalizedTexts.onboardingAge.tr()),
                              CustomText.w400(LocalizedTexts.onboardingSex.tr()),
                              CustomText.w400(LocalizedTexts.onboardingHeight.tr()),
                              CustomText.w400(LocalizedTexts.onboardingWeight.tr()),
                              CustomText.w400(LocalizedTexts.onboardingBmi.tr()),
                            ],
                          ),
                          const SizedBox(width: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.w600(
                                '${state.age} ${LocalizedTexts.onboardingYears.tr()}',
                                style: context.textTheme.bodyMedium,
                              ),
                              CustomText.w600(
                                state.sexType?.name.capitalize() ?? '',
                                style: context.textTheme.bodyMedium,
                              ),
                              CustomText.w600(
                                heightValue,
                                style: context.textTheme.bodyMedium,
                              ),
                              CustomText.w600(
                                weightValue,
                                style: context.textTheme.bodyMedium,
                              ),
                              CustomText.w600(
                                bmi.toString(),
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      BMIDescription(bmi: bmi),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ],
      ),
      button: CustomElevatedButton.blueFullWidth(
        onPressed: () => _onContinuePressed(context),
        label: LocalizedTexts.onboardingLetsMoveOn.tr(),
      ),
    );
  }
}
