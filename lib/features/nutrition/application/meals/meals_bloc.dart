import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_items_list_element.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_many_food_items_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_dish_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/dto/add_recipe_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

part 'meals_event.dart';

part 'meals_state.dart';

part 'meals_bloc.freezed.dart';

@singleton
class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final NutritionService nutritionService;

  MealsBloc(this.nutritionService) : super(const MealsState.initial()) {
    on<FetchMeals>(_onFetchMeals);
    on<FetchMealById>(_onFetchMealById);
    on<AddMeal>(_onAddMeal);

    on<UpdateFoodItemInMeal>(_onUpdateFoodItemInMeal);
    on<DeleteMeal>(_onDeleteMeal);
    on<DeleteFoodItemFromMeal>(_onDeleteFoodItemFromMeal);
    on<DeleteRecipeFromMeal>(_onDeleteRecipeFromMeal);
    on<CreateFromFavorites>(_onCreateFromFavorites);
    on<SetMealId>(_onSetMealId);
    on<SetCurrentDate>(_onSetCurrentDate);
    on<AddFoodItemToMeal>(_onAddFoodItemToMeal);
    on<AddRecipeToMeal>(_onAddRecipeToMeal);
    on<AddDishToMeal>(_onAddDishToMeal);
  }

  FutureOr<void> _onSetCurrentDate(
    SetCurrentDate event,
    Emitter<MealsState> emit,
  ) async {
    if (event.currentDate.isAfter(DateTime.now())) {
      emit(
        MealsState.mealsInfo(
          currentDate: event.currentDate,
          meals: <MealsListItem>[].toIList(),
        ),
      );
    } else {
      emit(const MealsState.loading());

      final response = await nutritionService.getMeals(
        startDate: event.currentDate
            .subtract(const Duration(days: 1))
            .toIso8601String(),
        endDate: event.currentDate.toIso8601String(),
      );

      response.fold(
        (error) {
          emit(MealsState.error(error));
        },
        (response) {
          emit(
            MealsState.mealsInfo(
              currentDate: event.currentDate,
              meals: response.data.toIList(),
              selectedServing: null,
            ),
          );
        },
      );
    }
  }

  FutureOr<void> _onSetMealId(
    SetMealId event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        emit(
          state.copyWith(currentMealId: event.mealId),
        );
      },
    );
  }

  FutureOr<void> _onFetchMeals(
    FetchMeals _,
    Emitter<MealsState> emit,
  ) async {
    emit(const MealsState.loading());

    final response = await nutritionService.getMeals(
      startDate:
          DateTime.now().subtract(const Duration(days: 8)).toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
    );

    response.fold(
      (error) {
        emit(MealsState.error(error));
      },
      (response) {
        emit(
          MealsState.mealsInfo(
            currentDate: DateTime.now(),
            meals: response.data.toIList(),
          ),
        );
      },
    );
  }

  FutureOr<void> _onFetchMealById(
    FetchMealById event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final response = await nutritionService.getMealById(event.id);

        response.fold(
          (error) => null,
          (response) {
            emit(
              state.copyWith(
                  meals: state.meals
                      .map((element) =>
                          element.id == event.id ? response : element)
                      .toIList()),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onAddDishToMeal(
    AddDishToMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        const numberOfUnits = 1;
        final dishId = event.dishId;

        var data = AddDishToMealBody(
          numberOfUnits: numberOfUnits,
          dishId: int.parse(dishId),
        );

        final response = await nutritionService.addDishToMeal(
          mealId: event.mealId,
          data: data,
        );

        response.fold((l) => null, (r) {
          emit(
            state.copyWith(
              meals: r.data.toIList(),
            ),
          );
        });
      },
    );
  }

  FutureOr<void> _onAddRecipeToMeal(
    AddRecipeToMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        const numberOfUnits = 1;

        const data = AddRecipeToMealBody(
          numberOfUnits: numberOfUnits,
        );

        final response = await nutritionService.addRecipeToMeal(
          mealId: event.mealId,
          recipeId: event.recipeId,
          data: data,
        );

        response.fold((l) => null, (r) {
          final updatedList = _getUpdatedMealsList(r);
          emit(
            state.copyWith(
              meals: updatedList.toIList(),
            ),
          );
        });
      },
    );
  }

  FutureOr<void> _onAddFoodItemToMeal(
    AddFoodItemToMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final servingId = state.selectedServing?.servingId;
        final numberOfUnits = state.selectedServing?.numberOfUnits;

        if (servingId == null) return;

        final data = AddFoodItemToMealBody(
          servingId: servingId,
          numberOfUnits: numberOfUnits,
        );

        final response = await nutritionService.addFoodItemToMeal(
          event.mealId,
          event.foodItemId,
          data,
        );

        response.fold(
          (l) => null,
          (r) {
            emit(
              state.copyWith(
                meals: r.data.toIList(),
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onUpdateFoodItemInMeal(
    UpdateFoodItemInMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final servingId = state.selectedServing?.servingId;
        final numberOfUnits = state.selectedServing?.numberOfUnits;

        if (servingId == null) return;

        final data = AddFoodItemToMealBody(
          servingId: servingId,
          numberOfUnits: numberOfUnits,
        );

        final response = await nutritionService.updateFoodItemInMeal(
          event.mealId,
          event.foodItemId,
          data,
        );

        response.fold((l) => null, (r) {
          final updatedList = _getUpdatedMealsList(r);

          emit(
            state.copyWith(
              meals: updatedList.toIList(),
            ),
          );
        });
      },
    );
  }

  FutureOr<void> _onDeleteFoodItemFromMeal(
    DeleteFoodItemFromMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final mealId = state.getCurrentMealId;

        if (mealId == null) return;

        final response = await nutritionService.removeFoodItemFromMeal(
          mealId,
          event.foodItemId,
        );

        response.fold(
          (l) => null,
          (r) {
            final updatedList = _getUpdatedMealsList(r);
            emit(
              state.copyWith(
                meals: updatedList.toIList(),
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onDeleteRecipeFromMeal(
    DeleteRecipeFromMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final mealId = state.getCurrentMealId;

        if (mealId == null) return;

        final response = await nutritionService.deleteRecipeFromMeal(
          mealId,
          event.recipeId,
        );

        response.fold(
          (l) => null,
          (r) {
            final updatedList = _getUpdatedMealsList(r);
            emit(
              state.copyWith(
                meals: updatedList.toIList(),
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onDeleteMeal(
    DeleteMeal event,
    Emitter<MealsState> emit,
  ) async {
    if (event.mealId == null) {
      return;
    }
    await state.mapOrNull(
      mealsInfo: (state) async {
        final mealId = event.mealId;
        if (mealId != null) {
          final response = await nutritionService.removeMeal(
            mealId,
          );

          response.fold(
            (l) => null,
            (r) {
              final updatedList = _deleteMealFromList(mealId);
              emit(
                state.copyWith(
                  meals: updatedList.toIList(),
                ),
              );
            },
          );
        }
      },
    );
  }

  FutureOr<void> _onCreateFromFavorites(
    CreateFromFavorites event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final mealId = state.currentMealId;
        if (mealId != null) {
          final manyFoodItemsListData = AddManyFoodItemsToMealBody(
            foodItems: event.foodItemList
                .map(
                  (element) => AddFoodItemsListElement(
                    externalFoodItemId: element.id,
                    numberOfUnits: element.serving.numberOfUnits,
                    servingId: element.serving.servingId ?? "0",
                  ),
                )
                .toList(),
          );

          final response = await nutritionService.addManyFoodItemsToMeal(
            mealId,
            manyFoodItemsListData,
          );

          response.fold(
            (l) => null,
            (r) {
              final updatedList = _getUpdatedMealsList(r);

              emit(
                state.copyWith(
                  currentMealId: mealId,
                  meals: updatedList,
                ),
              );
            },
          );
        }
      },
    );
  }

  FutureOr<void> _onAddMeal(
    AddMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      mealsInfo: (state) async {
        final data = AddMealBody(
          loggingDate: state.currentDate?.toIso8601String() ??
              DateTime.now().toIso8601String(),
          mealCategory: event.mealCategory,
        );

        final response = await nutritionService.addMeal(
          data,
        );

        response.fold(
          (l) => null,
          (r) {
            var updatedList = <MealsListItem>[].toIList();
            if (state.meals.isEmpty) {
              updatedList = (state.meals.toList()..add(r)).toIList();
            } else {
              if (!state.meals.toList().any((item) => item.id == r.id)) {
                updatedList = (state.meals.toList()..add(r)).toIList();
              } else {
                updatedList = state.meals;
              }
            }
            emit(
              state.copyWith(
                currentMealCategory: event.mealCategory,
                currentMealId: r.id,
                meals: updatedList,
              ),
            );
          },
        );
      },
    );
  }

  IList<MealsListItem> _getUpdatedMealsList(MealsListItem mealItem) {
    return state.maybeMap(
      mealsInfo: (state) {
        return state.meals
            .toList()
            .map((e) => e.id == mealItem.id ? mealItem : e)
            .toIList();
      },
      orElse: () => <MealsListItem>[].toIList(),
    );
  }

  IList<MealsListItem> _deleteMealFromList(int mealItem) {
    return state.maybeMap(
      mealsInfo: (state) {
        return state.meals.removeWhere((e) => e.id == mealItem).toIList();
      },
      orElse: () => <MealsListItem>[].toIList(),
    );
  }
}
