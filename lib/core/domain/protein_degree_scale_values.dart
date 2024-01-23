import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

final List<Range> proteinDegreeScaleValues = [
  Range(min: 0, max: 15, color: const Color(0xFFB7131E)),
  Range(min: 15, max: 20, color: const Color(0xFFCD9D52)),
  Range(min: 20, max: 25, color: const Color(0xFF73B642)),
  Range(min: 25, max: 99, color: const Color(0xFF24CB35)),
];

Color proteinDegreeScaleValuesColorForRange(double? density) {
  if (density == null) return AppColors.white;

  var retColor = proteinDegreeScaleValues
      .firstWhereOrNull((element) => (element.min <= density && density < element.max));

  return retColor?.color ?? AppColors.white;
}
