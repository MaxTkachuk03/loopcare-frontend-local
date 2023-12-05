import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (BuildContext context, OnboardingState state) {
        final stepsLength = OnboardingSteps.values.length;
        List<Widget> stepsList = [];

        for (var i = 0; i < stepsLength; i++) {
          final value = i < state.currentStep.index ? 100 : 0;

          stepsList.add(Flexible(
              child: _Item(
            progress: state.currentStep.index == i ? state.currentStepProgress : value,
          )));
        }

        return Row(children: stepsList);
      },
    );
  }
}

class _Item extends StatelessWidget {
  final int progress;

  const _Item({required this.progress});

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
              SizedBox(
                height: 4,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: 4,
                      width: constraints.maxWidth * progress / 100,
                      color: AppColors.darkGreen,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        progress == 100
            ? Row(
                children: [
                  const SizedBox(
                    width: 3.0,
                  ),
                  SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: Hexagon(
                      width: 20.0,
                      height: 20.0,
                      borderRadius: 0,
                      innerWidget: Container(
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                ],
              )
            : Container(
                height: 20,
                width: 20,
                decoration: const ShapeDecoration(
                  shape: PolygonBorder(
                    sides: 6,
                    rotate: 30.0,
                    side: BorderSide(color: AppColors.yellowLight, width: 4),
                  ),
                ),
              ),
      ],
    );
  }
}
