mixin NutritionUtils {
  double getCarbFiberRatio(double carbs, double fiber) {
    final result = carbs / fiber;
    return (result.isNaN || result.isInfinite) ? 0 : double.parse(result.toStringAsFixed(1));
  }

  double getProteinDegree(double protein, double calories) {
    final result = (((protein * 4) / calories) * 100);
    return (result.isNaN || result.isInfinite) ? 0 : result.roundToDouble();
  }

  double getCalorieDensity(double calories, double weight) {
    final result = calories / weight;
    return result.isNaN || result.isInfinite ? 0 : double.parse(result.toStringAsFixed(1));
  }

  double getCarbsPercent(double carbs, double calories) {
    final result = ((carbs * 4) / calories) * 100;
    return (result.isNaN || result.isInfinite) ? 0 : result;
  }
}
