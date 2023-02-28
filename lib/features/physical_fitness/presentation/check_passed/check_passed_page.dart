import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/small_filled_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/success_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/height_conversion_utils.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';

class CheckPassedPage extends StatelessWidget {
  const CheckPassedPage({Key? key}) : super(key: key);

  String _getHeightValue(bool useMetric, String heightInCm) {
    final heightFt = HeightConversionUtils.convertCMtoFeet(
      double.parse(heightInCm),
    );

    final heightInches = HeightConversionUtils.convertCMtoInches(
      double.parse(heightInCm),
    );

    final heightValue =
        useMetric ? '$heightInCm cm' : '$heightFt ft $heightInches in';

    return heightValue;
  }

  String _getWeightValue(bool useMetric, String weightInKg) {
    final weightLbs =
        WeightConversionUtils.convertKgToLbs(double.parse(weightInKg));

    return useMetric ? '$weightInKg kg' : '$weightLbs lbs';
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalQuestionWrap(
      child: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 86),
                SuccessContainer(
                  title: LocalizedTexts.fitnessCheckPassedTitle.tr(),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocalizedTexts.age.tr()),
                              Text(LocalizedTexts.height.tr()),
                              Text(LocalizedTexts.weight.tr()),
                              Text(LocalizedTexts.bmi.tr()),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BlocBuilder<PhysicalFitnessBloc,
                                  PhysicalFitnessState>(
                              builder: (BuildContext context, state) {
                            final isHeightMetric =
                                state.heightMeasurementSystemType ==
                                    MeasurementSystemType.metric;
                            final isWeightMetric =
                                state.weightMeasurementSystemType ==
                                    MeasurementSystemType.metric;

                            final heightValue = _getHeightValue(
                                isHeightMetric, state.heightInCm ?? '');

                            final weightValue = _getWeightValue(
                                isWeightMetric, state.weightInKg ?? '');

                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.age} years',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    heightValue,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    weightValue,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    '${state.bmi}',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ]);
                          })
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        LocalizedTexts.fitnessCheckPassedText.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: AppColors.blueDark),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SmallFilledButton(
                        text: LocalizedTexts.moreInfo.tr(),
                        onPressed: _onMoreInfoPressed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _onContinuePressed(context),
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.orangeDark),
                      ),
                  child: Text(LocalizedTexts.continueBtn.tr()),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onContinuePressed(BuildContext context) {
    context
      ..read<OnboardingBloc>().add(const OnboardingEvent.nextStep())
      ..router.pushNamed(AppRoutes.medicalIntro);
  }

  void _onMoreInfoPressed() {}
}
