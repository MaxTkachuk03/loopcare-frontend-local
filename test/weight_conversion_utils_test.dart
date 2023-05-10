import 'package:loopcare_frontend/features/physical_fitness/utils/weight_conversion_utils.dart';
import 'package:test/test.dart';

void main() {
  num convertedWeight(double weightLbs) {
    final weightKg = WeightConversionUtils.convertLbsToKg(weightLbs);

    return WeightConversionUtils.convertKgToLbs(weightKg.toDouble());
  }

  test('Test 180 lbs', () {
    const weightLbs = 180.0;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.1 lbs', () {
    const weightLbs = 180.1;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.2 lbs', () {
    const weightLbs = 180.2;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.3 lbs', () {
    const weightLbs = 180.3;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.4 lbs', () {
    const weightLbs = 180.4;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.5 lbs', () {
    const weightLbs = 180.5;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.6 lbs', () {
    const weightLbs = 180.6;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.7 lbs', () {
    const weightLbs = 180.7;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.8 lbs', () {
    const weightLbs = 180.8;

    expect(weightLbs, convertedWeight(weightLbs));
  });
  test('Test 180.9 lbs', () {
    const weightLbs = 180.9;

    expect(weightLbs, convertedWeight(weightLbs));
  });

  test('Test 1 lbs', () {
    const weightLbs = 1.0;

    expect(weightLbs, convertedWeight(weightLbs));
  });

  test('Test 1000 lbs', () {
    const weightLbs = 1000.0;

    expect(weightLbs, convertedWeight(weightLbs));
  });
}
