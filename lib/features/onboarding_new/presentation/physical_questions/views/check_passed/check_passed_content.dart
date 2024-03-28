import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_with_accents/text_with_accents.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/height_conversion_utils.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/weight_conversion_utils.dart';

class CheckPassedContent extends StatelessWidget {
  const CheckPassedContent({super.key});

  String _getHeightValue(bool useMetric, String heightInCm) {
    final int heightFt = HeightConversionUtils.doubleConvertCMtoFT(double.parse(heightInCm)).round();

    final int heightInches = HeightConversionUtils.doubleConvertCMtoFtIn(double.parse(heightInCm)).round();
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
    context.read<GeneralOnboardingBloc>().add(GeneralOnboardingEvent.excludeMentalQuestionsByGender(gender: state.genderType!));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<PhysicalQuestionsBloc>().state;

    final isHeightMetric = state.heightMeasurementSystemType.isMetric;
    final isWeightMetric = state.weightMeasurementSystemType.isMetric;

    final heightValue = _getHeightValue(isHeightMetric, state.heightInCm ?? '');

    final weightValue = _getWeightValue(isWeightMetric, state.weightInKg ?? '');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UnderAppbar.yellow(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
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
                    '${LocalizedTexts.physicalCheckPassedTitle.tr()}!',
                    style: context.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
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
                            CustomText.w400(LocalizedTexts.age.tr()),
                            CustomText.w400(LocalizedTexts.sex.tr()),
                            CustomText.w400(LocalizedTexts.height.tr()),
                            CustomText.w400(LocalizedTexts.weight.tr()),
                            CustomText.w400(LocalizedTexts.bmi.tr()),
                          ],
                        ),
                        const SizedBox(width: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.w600(
                              '${state.age} ${LocalizedTexts.years.tr()}',
                              style: context.textTheme.bodyMedium,
                            ),
                            CustomText.w600(
                              '${state.sexType?.name.capitalize()}',
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
                              '${state.bmi}',
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    TextWithAccents(
                      LocalizedTexts.bmiDescription1.tr(),
                      accents: [LocalizedTexts.bmiDescriptionAccent.tr()],
                    ),
                    const SizedBox(height: 20),
                    CustomText.w400(
                      LocalizedTexts.bmiDescription2.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
        MainContainer(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 42.0),
            child: CustomElevatedButton.blueFullWidth(
              onPressed: () => _onContinuePressed(context),
              label: LocalizedTexts.letsMoveOn.tr(),
            ),
          ),
        ),
      ],
    );
  }
}
