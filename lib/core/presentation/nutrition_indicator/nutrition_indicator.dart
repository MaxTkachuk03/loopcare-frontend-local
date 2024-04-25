import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

enum CustomCalorieDensityScaleLayoutSize { big, small }

class NutritionIndicator extends StatelessWidget {
  final String label;
  final Color color;
  final CustomCalorieDensityScaleLayoutSize? layoutSize;

  const NutritionIndicator({
    super.key,
    required this.color,
    required this.label,
    this.layoutSize = CustomCalorieDensityScaleLayoutSize.small,
  });

  factory NutritionIndicator.big({required Color color, required String label}) =>
      NutritionIndicator(color: color, label: label, layoutSize: CustomCalorieDensityScaleLayoutSize.big);

  factory NutritionIndicator.small({required Color color, required String label}) =>
      NutritionIndicator(color: color, label: label, layoutSize: CustomCalorieDensityScaleLayoutSize.small);

  double _widgetSize() => layoutSize == CustomCalorieDensityScaleLayoutSize.big ? 90.0 : 50.0;
  double _borderSize() => layoutSize == CustomCalorieDensityScaleLayoutSize.big ? 12.0 : 6.0;
  TextStyle? _textStyle(BuildContext context) => layoutSize == CustomCalorieDensityScaleLayoutSize.big
      ? context.textTheme.displayMedium
      : context.textTheme.bodySmall;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _widgetSize(),
      height: _widgetSize(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.blueDarker,
          borderRadius: BorderRadius.all(Radius.circular(_widgetSize() / 2)),
          border: Border.all(width: _borderSize(), color: color, style: BorderStyle.solid),
        ),
        child: Align(
          alignment: Alignment.center,
          child: CustomText.w600(label, style: _textStyle(context)?.copyWith(color: AppColors.white)),
        ),
      ),
    );
  }
}
