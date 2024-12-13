import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_indicator_color_picker.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_values_description.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/nutrition_indicator/nutrition_indicator.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/overlays/calorie_density_description.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/overlays/fiber_description.dart';
import 'package:loopcare_frontend/core/presentation/nutrition/overlays/protein_degree_description.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

const _calorieDensityKey = ValueKey<String>('calorieDensity');
const _proteinDegreeKey = ValueKey<String>('proteinDegree');
const _fiberKey = ValueKey<String>('fiber');

class NutritionScale extends StatelessWidget {
  final String topLabel;
  final String bottomLabel;
  final Color color;
  final double? value;
  final String indicatorLabel;
  final bool isDisabled;
  final double? totalCarbs;
  final double? carbsFiberRatio;
  final bool? isFiberInsignificant;

  const NutritionScale({
    super.key,
    this.totalCarbs,
    this.carbsFiberRatio,
    this.isFiberInsignificant,
    required this.topLabel,
    required this.bottomLabel,
    required this.color,
    required this.value,
    required this.isDisabled,
    required this.indicatorLabel,
  });

  Widget _getContent(BuildContext context) {
    switch (context.widget.key) {
      case _calorieDensityKey:
        return CalorieDensityDescription(calorieDensityValue: value);
      case _proteinDegreeKey:
        return ProteinDegreeDescription(proteinDegreeValue: value);
      case _fiberKey:
        return FiberDescription(
          fiberValue: value,
          totalCarbs: totalCarbs,
          carbsFiberRatio: carbsFiberRatio,
          isFiberInsignificant: isFiberInsignificant,
        );
      default:
        return CalorieDensityDescription(calorieDensityValue: value);
    }
  }

  void _onTapHandller(BuildContext context) =>
      ModalBottomSheet.nutritionIndicatorOverlay(context: context, content: _getContent(context));

  factory NutritionScale.calorieDensity({double? value}) => NutritionScale(
        key: _calorieDensityKey,
        topLabel: LocalizedTexts.nutritionCalorieDensity.tr(),
        bottomLabel: NutritionValuesDescription.getCalorieDensityItemByValue(value ?? 0)
            .label
            .tr()
            .capitalize(),
        color: NutritionIndicatorColorPicker.getIndicatorColor(
            NutritionIndicatorType.calorieDensity, value),
        value: value,
        indicatorLabel: '${value?.toStringAsFixed(1)}',
        isDisabled: value == 0,
      );

  factory NutritionScale.proteinDegree({double? value}) => NutritionScale(
        key: _proteinDegreeKey,
        topLabel: LocalizedTexts.nutritionProteinDegree.tr(),
        bottomLabel: NutritionValuesDescription.getProteinDegreeItemByValue(value ?? 0)
            .label
            .tr()
            .capitalize(),
        color: NutritionIndicatorColorPicker.getIndicatorColor(
            NutritionIndicatorType.proteinDegree, value),
        value: value,
        indicatorLabel: '${value?.round()}%',
        isDisabled: value == 0,
      );

  factory NutritionScale.fiber({
    double? value,
    required double? totalCarbs,
    required double? carbsFiberRatio,
    required bool isFiberInsignificant,
  }) =>
      NutritionScale(
        key: _fiberKey,
        topLabel: LocalizedTexts.nutritionFiber.tr().capitalize(),
        bottomLabel: isFiberInsignificant
            ? LocalizedTexts.notSignificant.tr()
            : NutritionValuesDescription.getFiberItemByValue(carbsFiberRatio ?? 0)
                .label
                .tr()
                .capitalize(),
        color: isFiberInsignificant
            ? AppColors.greyLight
            : NutritionIndicatorColorPicker.getIndicatorColor(
                NutritionIndicatorType.fiber, carbsFiberRatio),
        value: value,
        indicatorLabel: '${value?.toStringAsFixed(1)}g',
        isDisabled: value == 0 || totalCarbs == 0,
        totalCarbs: totalCarbs,
        carbsFiberRatio: carbsFiberRatio,
        isFiberInsignificant: isFiberInsignificant,
      );

  @override
  Widget build(BuildContext context) {
    final hasNewLine = topLabel.contains('\n');

    return InkWell(
      onTap: isDisabled ? null : () => _onTapHandller(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText.w600(
            topLabel,
            maxLines: hasNewLine ? 2 : 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
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
