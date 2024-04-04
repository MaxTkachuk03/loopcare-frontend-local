import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class GoalProgressIndicator extends StatelessWidget {
  final int steps;
  final int currentStep;
  final double innerSize;
  final double progressSize;
  final double strokeWidth;

  const GoalProgressIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    this.innerSize = 20.0,
    this.progressSize = 50,
    this.strokeWidth = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: innerSize,
          backgroundColor: AppColors.blueDarkest,
          child: _TextAccent(
            currentStep: currentStep,
            steps: steps,
          ),
        ),
        SizedBox.square(
          dimension: progressSize,
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            value: _calculateValue(),
            strokeWidth: strokeWidth,
            backgroundColor: AppColors.blueLightest,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.greenRegular),
          ),
        ),
      ],
    );
  }

  double _calculateValue() {
    return 1 * currentStep / steps;
  }
}

class _TextAccent extends StatelessWidget {
  final int currentStep;
  final int steps;

  const _TextAccent({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '$currentStep',
            style: context.textTheme.bodySmall?.copyWith(
                fontFamily: ThemeConstants.openSansFontFamily,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.54),
          ),
          TextSpan(
            text: '/',
            style: context.textTheme.bodySmall?.copyWith(
                fontFamily: ThemeConstants.openSansFontFamily,
                color: AppColors.blueLightest,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.54),
          ),
          TextSpan(
            text: '$steps',
            style: context.textTheme.bodySmall?.copyWith(
              fontFamily: ThemeConstants.openSansFontFamily,
              color: AppColors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
