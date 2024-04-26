import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

final List<Range> proteinDegreeScaleValues = [
  // TODO check ranges with Diana
  Range(min: 1, max: 6.99, color: AppColors.hq1),
  Range(min: 7, max: 8.99, color: AppColors.hq2),
  Range(min: 9, max: 10.99, color: AppColors.hq3),
  Range(min: 11, max: 12.99, color: AppColors.mq1),
  Range(min: 13, max: 15.99, color: AppColors.mq2),
  Range(min: 18, max: 19.99, color: AppColors.mq3),
  Range(min: 21, max: 23.99, color: AppColors.lq1),
  Range(min: 24, max: 26.99, color: AppColors.lq2),
  Range(min: 27, max: 29.99, color: AppColors.lq3),
  Range(min: 30, max: 100, color: AppColors.lq4),
];

Color proteinDegreeColor(double? value) {
  if (value == null || value < proteinDegreeScaleValues.first.min) return AppColors.white;

  if (value > proteinDegreeScaleValues.last.max) return AppColors.lq4;

  final val = proteinDegreeScaleValues.firstWhere((e) => (e.min <= value && value < e.max));

  return val.color;
}
