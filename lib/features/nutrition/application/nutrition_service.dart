import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/get_dashboard_weights_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/log_weight_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/log_weight_response.dart';

import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_dish_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/add_food_item_to_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/clone_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_dish_food_item_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dto/update_food_item_in_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/dto/update_dish_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_food_item_to_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_recipe_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/recipe_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_food_item_in_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/update_recipe_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/dto/recipe_details_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/dto/favorites_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/dto/barcode_information_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_many_food_items_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/dto/values_explanation_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/dto/get_dishes_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/add_to_favorites_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/add_to_favorites_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_servings_response.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/update_favorite_body.dart';

abstract class NutritionService {
  Future<Either<RequestError, ValuesExplanationResponse>>
      getValuesExplanation();

  Future<Either<RequestError, FavoritesResponse>> getFavorites(
      List<String>? mealCategories);

  Future<Either<RequestError, FoodItemServingsResponse>> getFoodItemServings(
    String id,
  );

  Future<Either<RequestError, AddToFavoritesResponse>> addToFavorites(
    String foodItemId,
    String servingId,
    AddToFavoritesBody data,
  );

  Future<Either<RequestError, AddToFavoritesResponse>> removeFromFavorites(
    String foodItemId,
    String? servingId,
  );

  Future<Either<RequestError, AddToFavoritesResponse>> updateFavorites(
    String foodItemId,
    String? servingId,
    UpdateFavoriteBody data,
  );

  Future<Either<RequestError, BarcodeInformationResponse>>
      getBarcodeInformation(
    String barCode,
  );

  Future<Either<RequestError, RecipeDetailsResponse>> getRecipe(int id);

  Future<Either<RequestError, RecipeResponse>> addFoodItemToRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
    required AddFoodItemToRecipeBody data,
  });

  Future<Either<RequestError, RecipeResponse>> updateFoodItemInRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
    required UpdateFoodItemInRecipeBody data,
  });

  Future<Either<RequestError, RecipeResponse>> removeFoodItemFromRecipeInMeal({
    required int mealId,
    required int recipeId,
    required String foodItemId,
  });

  Future<Either<RequestError, RecipeResponse>> updateRecipeNumberOfServing({
    required int mealId,
    required int recipeId,
    required UpdateRecipeBody data,
  });

  Future<Either<RequestError, RecipeResponse>> getRecipeInMeal(
    int mealId,
    int recipeId,
  );

  Future<Either<RequestError, MealsListItem>> deleteRecipeFromMeal(
    int mealId,
    String recipeId,
  );

  Future<Either<RequestError, MealsResponse>> getMeals({
    String? startDate,
    String? endDate,
  });

  Future<Either<RequestError, MealsListItem>> addMeal(
    AddMealBody data,
  );

  Future<Either<RequestError, MealsListItem>> getMealById(
    int mealId,
  );

  Future<Either<RequestError, MealsResponse>> removeMeal(
    int mealId,
  );

  Future<Either<RequestError, MealsListItem>> addFoodItemToMeal(
    int mealId,
    String foodItemId,
    AddFoodItemToMealBody data,
  );

  Future<Either<RequestError, MealsListItem>> addManyFoodItemsToMeal(
    int mealId,
    AddManyFoodItemsToMealBody data,
  );

  Future<Either<RequestError, MealsListItem>> addRecipeToMeal({
    required int mealId,
    required String recipeId,
    required AddRecipeToMealBody data,
  });

  Future<Either<RequestError, MealsListItem>> updateFoodItemInMeal(
    int mealId,
    int foodItemId,
    AddFoodItemToMealBody data,
  );

  Future<Either<RequestError, MealsListItem>> removeFoodItemFromMeal(
    int mealId,
    String foodItemId,
  );

  Future<Either<RequestError, SearchResponse>> search(
    String query, {
    List<String>? mode,
    int? limit,
  });

  Future<Either<RequestError, GetDashboardWeightsResponse>> getDashboardWeights(
    String startDate,
    String endDate,
  );

  Future<Either<RequestError, LogWeightResponse>> logWeight(
    LogWeightBody data,
  );

  Future<Either<RequestError, GetDishesResponse>> getDishes(
    List<String>? mealCategories,
  );

  Future<Either<RequestError, UpdateDishFoodItemResponse>> getDishById(
    int id,
  );

  Future<Either<RequestError, UpdateDishFoodItemResponse>> updateDishById(
    int id,
    UpdateDishBody data,
  );

  Future<Either<RequestError, UpdateDishFoodItemResponse>> cloneDish(
    CloneDishBody data,
  );

  Future<Either<RequestError, UpdateDishFoodItemResponse>> updateFoodItemInDish(
    int dishId,
    String internalFoodItemId,
    UpdateFoodItemInDishBody data,
  );

  Future<Either<RequestError, UpdateDishFoodItemResponse>>
      deleteFoodItemFromDish(
    int dishId,
    int internalFoodItemId,
  );

  Future<Either<RequestError, MealsListItem>> addDishToMeal(
    int mealId,
    AddDishToMealBody data,
  );

  Future<Either<RequestError, UpdateDishFoodItemResponse>> deleteDish(
    int dishId,
  );

  Future<Either<RequestError, UpdateDishFoodItemResponse>> addFoodItemToDish(
    int dishId,
    AddFoodItemToDishBody data,
  );
}
