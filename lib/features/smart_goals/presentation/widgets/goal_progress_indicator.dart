import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

const achieveRadius = 14.0;

class GoalProgressIndicator extends StatelessWidget {
  final int steps;
  final int currentStep;
  final double innerSize;
  final double progressSize;
  final double strokeWidth;
  final bool isAchievedNotifier;

  const GoalProgressIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    this.innerSize = 18.0,
    this.progressSize = 47,
    this.strokeWidth = 12,
    required this.isAchievedNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: progressSize,
      height: isAchievedNotifier ? progressSize + innerSize + achieveRadius : progressSize + innerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
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
              Positioned(
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: innerSize,
                  backgroundColor: AppColors.blueDarkest,
                  child: _TextAccent(
                    currentStep: currentStep,
                    steps: steps,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            child: Visibility(
              visible: isAchievedNotifier,
              child: CircleAvatar(
                radius: achieveRadius,
                backgroundColor: AppColors.yellowRegular,
                child: AppIcons.achieve,
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
