import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendation_recipe.freezed.dart';

part 'recommendation_recipe.g.dart';

@freezed
class RecommendationRecipe with _$RecommendationRecipe {
  const factory RecommendationRecipe({
    required String externalId,
    required String name,
    required List<String> mealCategories,
    required int id,
    required List<int> classificationTags,
    required List<int> categoryTags,
    required List<int> ingredientTags,
    required double calorieDensity,
    required double proteinDegree,
    required DateTime syncDate,
    required int? cookingTimeMin,
    required int? preparationTimeMin,
    required List<String>? image,
    required String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RecommendationRecipe;

  factory RecommendationRecipe.fromJson(Map<String, dynamic> json) =>
      _$RecommendationRecipeFromJson(json);
}
