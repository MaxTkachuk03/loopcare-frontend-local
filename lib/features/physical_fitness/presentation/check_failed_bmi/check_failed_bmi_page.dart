import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/bmi_calculator.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/bmi_validator.dart';

class CheckFailedBmiPage extends StatelessWidget {
  const CheckFailedBmiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedTexts.bodyAndMind.translation),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.only(
                    top: 35,
                    bottom: 59,
                    left: 32,
                    right: 32,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocalizedTexts.yourBodyMassIndex.translation),
                      BlocBuilder<PhysicalFitnessBloc, PhysicalFitnessState>(
                        builder: (BuildContext context, state) {
                          final bmiIndex = BmiCalculator.getUserBmiIndex(
                            state.heightInCm,
                            state.weightInKg,
                          );

                          return Text(
                            '$bmiIndex',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.blueDark),
                          );
                        },
                      ),
                      const SizedBox(height: 26),
                      BlocBuilder<PhysicalFitnessBloc, PhysicalFitnessState>(
                        builder: (BuildContext context, state) {
                          final bmiMaxValue = BmiValidator.getMaxBmiIndexValue(state.age ?? 0);
                          final bmiMinValue = BmiValidator.getMinBmiIndexValue();

                          return Text(
                            LocalizedTexts.fitnessCheckFailedInformationsText.tr(
                              namedArgs: {
                                'bmiMaxIndex': bmiMaxValue,
                                'bmiMinIndex': bmiMinValue,
                              },
                            ),
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                        },
                      ),
                      const SizedBox(height: 26),
                      // Text(LocalizedTexts
                      //     .fitnessCheckFailedAdviceText.translation),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
