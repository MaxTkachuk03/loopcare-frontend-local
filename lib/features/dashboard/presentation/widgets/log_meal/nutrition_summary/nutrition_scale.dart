import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_indicator_color_picker.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_values_description.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/nutrition_indicator/nutrition_indicator.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_summary/calorie_density_description.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_summary/fiber_description.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_summary/protein_degree_description.dart';

class NutritionScale extends StatelessWidget {
  final String topLabel;
  final String bottomLabel;
  final Color color;
  final double? value;
  final String indicatorLabel;
  final bool isDisabled;
  final double? totalCarbs;
  final double? carbsFiberRatio;

  const NutritionScale({
    super.key,
    this.totalCarbs,
    this.carbsFiberRatio,
    required this.topLabel,
    required this.bottomLabel,
    required this.color,
    required this.value,
    required this.isDisabled,
    required this.indicatorLabel,
  });

  Widget _getContent(BuildContext context) {
    const calorieDensityKey = ValueKey<String>('calorieDensity');
    const proteinDegreeKey = ValueKey<String>('proteinDegree');
    const fiberKey = ValueKey<String>('fiber');

    switch (context.widget.key) {
      case calorieDensityKey:
        return CalorieDensityDescription(calorieDensityValue: value);
      case proteinDegreeKey:
        return ProteinDegreeDescription(proteinDegreeValue: value);
      case fiberKey:
        return FiberDescription(fiberValue: value, totalCarbs: totalCarbs, carbsFiberRatio: carbsFiberRatio);
      default:
        return CalorieDensityDescription(calorieDensityValue: value);
    }
  }

  void _onTapHandller(BuildContext context) =>
      ModalBottomSheet.nutritionIndicatorOverlay(context: context, content: _getContent(context));

  factory NutritionScale.calorieDensity({double? value}) => NutritionScale(
        key: const ValueKey<String>('calorieDensity'),
        topLabel: LocalizedTexts.calorieDensity.tr(),
        bottomLabel:
            NutritionValuesDescription.getCalorieDensityItemByValue(value ?? 0).label.tr().capitalize(),
        color: NutritionIndicatorColorPicker.getIndicatorColor(NutritionIndicatorType.calorieDensity, value),
        value: value,
        indicatorLabel: '${value?.toStringAsFixed(1)}',
        isDisabled: value == 0,
      );

  factory NutritionScale.proteinDegree({double? value}) => NutritionScale(
        key: const ValueKey<String>('proteinDegree'),
        topLabel: LocalizedTexts.proteinDegree.tr(),
        bottomLabel:
            NutritionValuesDescription.getProteinDegreeItemByValue(value ?? 0).label.tr().capitalize(),
        color: NutritionIndicatorColorPicker.getIndicatorColor(NutritionIndicatorType.proteinDegree, value),
        value: value,
        indicatorLabel: '${value?.round()}%',
        isDisabled: value == 0,
      );

  factory NutritionScale.fiber(
          {double? value, required double? totalCarbs, required double? carbsFiberRatio}) =>
      NutritionScale(
        key: const ValueKey<String>('fiber'),
        topLabel: LocalizedTexts.fiber.tr().capitalize(),
        bottomLabel: NutritionValuesDescription.getFiberItemByValue(value ?? 0).label.tr().capitalize(),
        color: NutritionIndicatorColorPicker.getIndicatorColor(NutritionIndicatorType.fiber, carbsFiberRatio),
        value: value,
        indicatorLabel: '${value?.toStringAsFixed(1)}g',
        isDisabled: value == 0,
        totalCarbs: totalCarbs,
        carbsFiberRatio: carbsFiberRatio,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // TODO uncomment
      // onTap: isDisabled ? null : () => _onTapHandller(context),
      onTap: () => _onTapHandller(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText.w600(topLabel, style: context.textTheme.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 8.0),
          NutritionIndicator.small(
            label: isDisabled ? '-' : indicatorLabel,
            color: isDisabled ? AppColors.blueLightest : color,
          ),
          const SizedBox(height: 8.0),
          CustomText.w600(
            isDisabled ? '-' : bottomLabel,
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
