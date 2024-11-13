enum NutritionValuesTypes {
  calcium,
  calories,
  carbohydrate,
  cholesterol,
  fat,
  fiber,
  iron,
  monounsaturatedFat,
  polyunsaturatedFat,
  potassium,
  protein,
  saturatedFat,
  sodium,
  sugar,
  transFat,
  vitaminA,
  vitaminC,
  vitaminD,
}

extension NutritionValuesTypesX on NutritionValuesTypes {
  String get unitLabel {
    switch (this) {
      case NutritionValuesTypes.calories:
        return 'kcal';
      case NutritionValuesTypes.sodium:
      case NutritionValuesTypes.potassium:
      case NutritionValuesTypes.cholesterol:
      case NutritionValuesTypes.vitaminC:
      case NutritionValuesTypes.calcium:
      case NutritionValuesTypes.iron:
        return 'mg';
      case NutritionValuesTypes.vitaminA:
      case NutritionValuesTypes.vitaminD:
        return 'mcg';
      default:
        return 'g';
    }
  }
}
