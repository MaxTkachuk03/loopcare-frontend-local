import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_values.dart';
import 'package:test/test.dart';

void main() {
  test('calorieDensityScaleValues 0.0', () {
    const density = 0.0;
    var testColor = calorieDensityScaleValuesColorForRange(density);

    expect(const Color(0xFF24CB35), testColor);
  });

  test('calorieDensityScaleValues 1.0', () {
    const density = 1.0;
    var testColor = calorieDensityScaleValuesColorForRange(density);

    expect(const Color(0xFF60BB3F), testColor);
  });

  test('calorieDensityScaleValues 2', () {
    const density = 2.0;
    var testColor = calorieDensityScaleValuesColorForRange(density);

    expect(const Color(0xFFD96A44), testColor);
  });
  test('calorieDensityScaleValues 5', () {
    const density = 5.0;
    var testColor = calorieDensityScaleValuesColorForRange(density);

    expect(const Color(0xFFB7131E), testColor);
  });

  test('calorieDensityScaleValues 50', () {
    const density = 50.0;
    var testColor = calorieDensityScaleValuesColorForRange(density);

    expect(const Color(0xFFB7131E), testColor);
  });

  test('calorieDensityScaleValues 500', () {
    const density = 500.0;
    var testColor = calorieDensityScaleValuesColorForRange(density);

    expect(const Color(0xFFB7131E), testColor);
  });
}
