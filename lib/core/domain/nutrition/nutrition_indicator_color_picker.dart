import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class Range {
  final double min;
  final double max;
  final Color color;
  final String? description;

  Range({required this.min, required this.max, required this.color, this.description});
}

enum NutritionIndicatorType { calorieDensity, proteinDegree, fiber }

class NutritionIndicatorColorPicker {
  NutritionIndicatorColorPicker._();

  static final List<Range> calorieDensityScaleValues = [
    Range(min: 0, max: 0.99, color: AppColors.hq1),
    Range(
      min: 1,
      max: 1.29,
      color: AppColors.hq2,
      description: LocalizedTexts.calorieDensityHighQualityLabel.tr(),
    ),
    Range(min: 1.3, max: 1.49, color: AppColors.hq3),
    Range(min: 1.5, max: 1.649, color: AppColors.mq1),
    Range(
      min: 1.65,
      max: 1.749,
      color: AppColors.mq2,
      description: LocalizedTexts.calorieDensityMidQualityLabel.tr(),
    ),
    Range(min: 1.75, max: 1.89, color: AppColors.mq3),
    Range(min: 1.90, max: 2.09, color: AppColors.lq1),
    Range(min: 2.10, max: 2.29, color: AppColors.lq2),
    Range(
        min: 2.30,
        max: 2.59,
        color: AppColors.lq3,
        description: LocalizedTexts.calorieDensityLowQualityLabel.tr()),
    Range(min: 2.60, max: 100, color: AppColors.lq4),
  ];

  static final List<Range> proteinDegreeScaleValues = [
    Range(min: 1, max: 6.99, color: AppColors.lq4),
    Range(
      min: 7,
      max: 8.99,
      color: AppColors.lq3,
      description: LocalizedTexts.proteinDegreeLowQualityLabel.tr(),
    ),
    Range(min: 9, max: 10.99, color: AppColors.lq2),
    Range(min: 11, max: 12.99, color: AppColors.lq1),
    Range(
      min: 13,
      max: 16.99,
      color: AppColors.mq3,
      description: LocalizedTexts.proteinDegreeLowMidQualityLabel.tr(),
    ),
    Range(min: 17, max: 19.99, color: AppColors.mq2),
    Range(
      min: 20,
      max: 23.99,
      color: AppColors.mq1,
      description: LocalizedTexts.proteinDegreeMidQualityLabel.tr(),
    ),
    Range(min: 24, max: 26.99, color: AppColors.hq3),
    Range(
      min: 27,
      max: 29.99,
      color: AppColors.hq2,
      description: LocalizedTexts.proteinDegreeHighQualityLabel.tr(),
    ),
    Range(min: 30, max: 100, color: AppColors.hq1),
  ];

  static final List<Range> carbFiberRatioValues = [
    Range(min: 1, max: 5.99, color: AppColors.hq1),
    Range(
      min: 6,
      max: 8.99,
      color: AppColors.hq2,
      description: LocalizedTexts.fiberHighQualityLabel.tr(),
    ),
    Range(min: 9, max: 12.99, color: AppColors.hq3),
    Range(min: 13, max: 16.99, color: AppColors.mq1),
    Range(
      min: 17,
      max: 19.99,
      color: AppColors.mq2,
      description: LocalizedTexts.fiberMidQualityLabel.tr(),
    ),
    Range(min: 20, max: 24.99, color: AppColors.mq3),
    Range(min: 25, max: 26.99, color: AppColors.lq1),
    Range(
      min: 27,
      max: 28.99,
      color: AppColors.lq2,
      description: LocalizedTexts.fiberLowQualityLabel.tr(),
    ),
    Range(min: 29, max: 30.99, color: AppColors.lq3),
    Range(min: 31, max: 100, color: AppColors.lq4),
  ];

  static List<Range> _getColorsList(NutritionIndicatorType type) {
    switch (type) {
      case NutritionIndicatorType.calorieDensity:
        return calorieDensityScaleValues;
      case NutritionIndicatorType.proteinDegree:
        return proteinDegreeScaleValues;
      case NutritionIndicatorType.fiber:
        return carbFiberRatioValues;
    }
  }

  static Color getIndicatorColor(NutritionIndicatorType type, double? value) {
    final list = _getColorsList(type);

    if (value == null || value < list.first.min) return AppColors.white;

    if (value > list.last.max) return list.last.color;

    return list.firstWhere((e) => (e.min <= value && value < e.max), orElse: () => list.last).color;
  }
}
