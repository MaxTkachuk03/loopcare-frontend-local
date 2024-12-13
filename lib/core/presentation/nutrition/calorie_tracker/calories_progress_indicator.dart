import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:shimmer/shimmer.dart';

class CaloriesProgressIndicator extends StatelessWidget {
  final double value;
  final Animation<Color?>? valueColor;
  final Color? backgroundColor;
  final bool withShimmering;

  const CaloriesProgressIndicator({
    super.key,
    required this.value,
    this.valueColor = const AlwaysStoppedAnimation<Color>(AppColors.blueRegular),
    this.backgroundColor = AppColors.blueLightest,
    this.withShimmering = false,
  });

  factory CaloriesProgressIndicator.error() => const CaloriesProgressIndicator(
        value: 0,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.greyLight),
        backgroundColor: AppColors.greyLight,
      );

  factory CaloriesProgressIndicator.loading() =>
      const CaloriesProgressIndicator(value: 0, withShimmering: true);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0, end: value),
      builder: (context, value, _) => withShimmering
          ? Shimmer.fromColors(
              baseColor: AppColors.greyLight,
              highlightColor: AppColors.greyRegular,
              child: LinearProgressIndicator(
                minHeight: 15.0,
                valueColor: valueColor,
                backgroundColor: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                value: value,
              ),
            )
          : LinearProgressIndicator(
              minHeight: 15.0,
              valueColor: valueColor,
              backgroundColor: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              value: value,
            ),
    );
  }
}
