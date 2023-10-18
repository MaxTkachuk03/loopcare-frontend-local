import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';

Color getCalorieDensityColor(double calorieDensity) {
  Range item = calorieDensityScaleValues.firstWhere((e) {
    return e.min <= calorieDensity && calorieDensity <= e.max;
  }, orElse: () => calorieDensityScaleValues[calorieDensityScaleValues.length - 1]);

  return item.color;
}
