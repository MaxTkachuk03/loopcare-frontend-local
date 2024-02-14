import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/height_conversion_utils.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/weight_conversion_utils.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class CheckPassedPage extends StatelessWidget {
  const CheckPassedPage({super.key});

  String _getHeightValue(bool useMetric, String heightInCm) {
    final heightFt = HeightConversionUtils.convertCMtoFT(
      int.parse(heightInCm),
    );

    final heightInches = HeightConversionUtils.convertCMtoFtIn(
      int.parse(heightInCm),
    );

    final heightValue = useMetric ? '$heightInCm cm' : '$heightFt ft $heightInches in';

    return heightValue;
  }

  String _getWeightValue(bool useMetric, String weightInKg) {
    final weightLbs = WeightConversionUtils.convertKgToLbs(double.parse(weightInKg));

    return useMetric ? '$weightInKg kg' : '$weightLbs lbs';
  }

  void _onContinuePressed(BuildContext context) {
    context
      ..read<OnboardingBloc>().add(const OnboardingEvent.nextStep())
      ..router.pushNamed(AppRoutes.medicalIntro);
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: CustomScaffold.yellow(
        appBar: CustomAppBar.yellow(
          title: LocalizedTexts.physicalIntroTitle.tr(),
          leading: CustomFilledIconButton.leadingYellowLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ProgressBar.blue(backgroundColor: AppColors.yellowRegular),
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
                  ],
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
                                BlocBuilder<PhysicalFitnessBloc, PhysicalFitnessState>(
                                    builder: (BuildContext context, state) {
                                  final isHeightMetric =
                                      state.heightMeasurementSystemType == MeasurementSystemType.metric;
                                  final isWeightMetric =
                                      state.weightMeasurementSystemType == MeasurementSystemType.metric;

                                  final heightValue = _getHeightValue(isHeightMetric, state.heightInCm ?? '');

                                  final weightValue = _getWeightValue(isWeightMetric, state.weightInKg ?? '');

                                  AnalyticsEventService.instance.logEvent(
                                    FirebaseEvents.userBmi,
                                    parameters: {
                                      CustomDefinitions.value: '${state.bmi}',
                                    },
                                  );

                                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                  ]);
                                })
                              ],
                            ),
                            const SizedBox(height: 32),
                            CustomText.w400(
                              LocalizedTexts.bmiDescription.tr(),
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
                  child: Column(
                    children: [
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onContinuePressed(context),
                        label: LocalizedTexts.letsMoveOn.tr(),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
