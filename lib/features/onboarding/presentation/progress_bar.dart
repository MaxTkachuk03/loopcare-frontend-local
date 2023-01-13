import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (BuildContext context, OnboardingState state) {
        // print('OnboardingBloc ${state.currentStepProgress}');

        final stepsLength = OnboardingSteps.values.length;
        List<Widget> stepsList = [];

        for (var i = 0; i < stepsLength; i++) {
          final value = i < state.currentStep.index ? 100 : 0;

          stepsList.add(Flexible(
              child: _Item(
            progress: state.currentStep.index == i
                ? state.currentStepProgress
                : value,
          )));
        }

        return Row(children: stepsList);
      },
    );
  }
}

class _Item extends StatelessWidget {
  final int progress;

  const _Item({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 4,
                color: AppColors.yellowLight,
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    height: 4,
                    width: constraints.maxWidth * progress / 100,
                    color: AppColors.darkGreen,
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                progress == 100 ? AppColors.darkGreen : AppColors.yellowLight,
          ),
        )
      ],
    );
  }
}
