import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class ProgressBar extends StatelessWidget {
  final int stepsLength; // 3
  final int currentStepIndex; // 2 (starts from 0)
  final int currentStepProgress; // 90 percetage

  const ProgressBar({
    Key? key,
    required this.stepsLength,
    required this.currentStepIndex,
    required this.currentStepProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (BuildContext context, OnboardingState state) {
        return Text('1234');
      },
    );
  }
}
