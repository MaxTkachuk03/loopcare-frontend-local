import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class ProgressBar extends StatelessWidget {
  final Color backgroundColor;
  final Color? progressFillColor;
  final Color? progressEmptyColor;

  const ProgressBar({
    super.key,
    required this.backgroundColor,
    this.progressFillColor,
    this.progressEmptyColor,
  });

  factory ProgressBar.coral({required Color backgroundColor}) => ProgressBar(
        backgroundColor: backgroundColor,
        progressFillColor: AppColors.coralDarker,
        progressEmptyColor: AppColors.white,
      );

  factory ProgressBar.orange({required Color backgroundColor}) => ProgressBar(
        backgroundColor: backgroundColor,
        progressFillColor: AppColors.orangeDarker,
        progressEmptyColor: AppColors.white,
      );

  factory ProgressBar.yellow({required Color backgroundColor}) => ProgressBar(
        backgroundColor: backgroundColor,
        progressFillColor: AppColors.yellowDarker,
        progressEmptyColor: AppColors.white,
      );

  factory ProgressBar.green({required Color backgroundColor}) => ProgressBar(
        backgroundColor: backgroundColor,
        progressFillColor: AppColors.greenDarker,
        progressEmptyColor: AppColors.white,
      );

  factory ProgressBar.petrol({required Color backgroundColor}) => ProgressBar(
        backgroundColor: backgroundColor,
        progressFillColor: AppColors.petrolDarker,
        progressEmptyColor: AppColors.white,
      );

  factory ProgressBar.blue({required Color backgroundColor}) => ProgressBar(
        backgroundColor: backgroundColor,
        progressFillColor: AppColors.blueDarker,
        progressEmptyColor: AppColors.white,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (BuildContext context, OnboardingState state) {
        final stepsLength = OnboardingSteps.values.length;
        List<Widget> stepsList = [];

        for (var i = 0; i < stepsLength; i++) {
          final value = i < state.currentStep.index ? 100 : 0;

          stepsList.add(
            Flexible(
              child: _Item(
                progress: state.currentStep.index == i ? state.currentStepProgress : value,
                progressFillColor: progressFillColor ?? AppColors.blueDarker,
                progressEmptyColor: progressEmptyColor ?? AppColors.white,
              ),
            ),
          );
        }

        return Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12.0),
          child: Row(children: stepsList),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final Color progressFillColor;
  final Color progressEmptyColor;
  final int progress;

  const _Item({required this.progress, required this.progressFillColor, required this.progressEmptyColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(height: 4, color: progressEmptyColor),
              SizedBox(
                height: 4,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: 4,
                      width: constraints.maxWidth * progress / 100,
                      color: progressFillColor,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(radius: 10, backgroundColor: progress == 100 ? progressFillColor : progressEmptyColor)
      ],
    );
  }
}
