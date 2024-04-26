import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

final List<Range> carbFiberRatioValues = [
  Range(min: 1, max: 5.99, color: AppColors.hq1),
  Range(min: 6, max: 8.99, color: AppColors.hq2),
  Range(min: 9, max: 12.99, color: AppColors.hq3),
  Range(min: 13, max: 16.99, color: AppColors.mq1),
  Range(min: 17, max: 19.99, color: AppColors.mq2),
  Range(min: 20, max: 24.99, color: AppColors.mq3),
  Range(min: 25, max: 26.99, color: AppColors.lq1),
  Range(min: 27, max: 28.99, color: AppColors.lq2),
  Range(min: 29, max: 30.99, color: AppColors.lq3),
  Range(min: 31, max: 100, color: AppColors.lq4),
];

Color carbFiberRatioColor(double? ratio) {
  if (ratio == null || ratio < carbFiberRatioValues.first.min) return AppColors.white;

  if (ratio > carbFiberRatioValues.last.max) return AppColors.lq4;

  return carbFiberRatioValues.firstWhere((e) => (e.min <= ratio && ratio < e.max)).color;
}
