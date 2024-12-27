import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

const counterRadius = 20.0;

class GoalProgressIndicator extends StatelessWidget {
  final int steps;
  final int currentStep;
  final double innerSize;
  final double progressSize;
  final double strokeWidth;
  final bool isAchievedNotifier;
  final Color? valueColor;

  const GoalProgressIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    this.innerSize = counterRadius,
    this.progressSize = 48,
    this.strokeWidth = 8,
    required this.isAchievedNotifier,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: progressSize,
      height: progressSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.square(
            dimension: progressSize,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              value: _calculateValue(),
              strokeWidth: strokeWidth,
              backgroundColor: AppColors.blueLightest,
              valueColor: AlwaysStoppedAnimation<Color>(valueColor ?? AppColors.greenRegular),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: innerSize,
              backgroundColor: AppColors.blueRegular,
              child: _TextAccent(
                currentStep: currentStep,
                steps: steps,
              ),
            ),
          ),
        ],
      ),
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
    required this.currentStep,
    required this.steps,
  });

  TextStyle? getStyle(BuildContext context, [Color? color = AppColors.white]) =>
      context.textTheme.bodySmall?.copyWith(color: color, letterSpacing: 1.54);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2 * counterRadius,
      alignment: Alignment.center,
      child: FittedBox(
        child: RichText(
          text: TextSpan(
            style: context.textTheme.bodySmall,
            children: <InlineSpan>[
              TextSpan(
                text: '$currentStep',
                style: getStyle(context),
              ),
              TextSpan(
                text: '/',
                style: getStyle(context, AppColors.blueLightest),
              ),
              TextSpan(
                text: '$steps',
                style: getStyle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
