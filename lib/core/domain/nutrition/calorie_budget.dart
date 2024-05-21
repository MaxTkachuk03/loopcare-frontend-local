import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:loopcare_frontend/core/domain/nutrition/phisical_frequency_range.dart';

class CalorieBudget {
  CalorieBudget._();

  static const double _noExerciseMultiplier = 1.2;
  static const double _lightExerciseMultiplier = 1.375;
  static const double _moderateExerciseMultiplier = 1.55;
  static const double _heavyExerciseMultiplier = 1.725;

  static const PhysicalFrequencyRange _lightMultiplierRange = PhysicalFrequencyRange.light();
  static const PhysicalFrequencyRange _moderateMultiplierRange = PhysicalFrequencyRange.moderate();
  static const PhysicalFrequencyRange _heavyMultiplierRange = PhysicalFrequencyRange.heavy();

  static double getNutritionActivityMultiplier(int activitiesFrequency) {
    if (activitiesFrequency.isInRange(_lightMultiplierRange.min, _lightMultiplierRange.max)) {
      return _lightExerciseMultiplier;
    } else if (activitiesFrequency.isInRange(_moderateMultiplierRange.min, _moderateMultiplierRange.max)) {
      return _moderateExerciseMultiplier;
    } else if (activitiesFrequency.isInRange(_heavyMultiplierRange.min, _heavyMultiplierRange.max)) {
      return _heavyExerciseMultiplier;
    } else {
      return _noExerciseMultiplier;
    }
  }
}
