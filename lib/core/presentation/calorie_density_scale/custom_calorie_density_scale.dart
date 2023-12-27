import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

enum CustomCalorieDensityScaleLayoutSize {
  big,
  small,
}

class CustomCalorieDensityScale extends StatelessWidget {
  final double? density;
  final String? label;
  final CustomCalorieDensityScaleLayoutSize layoutSize;

  const CustomCalorieDensityScale({
    super.key,
    this.density,
    this.label,
    this.layoutSize = CustomCalorieDensityScaleLayoutSize.big,
  });

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
          border: Border.all(
            width: _borderSize(),
            color: calorieDensityScaleValuesColorForRange(density),
            style: BorderStyle.solid,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: CustomText.w600(
            label ?? '0',
            style: _textStyle(context)?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
