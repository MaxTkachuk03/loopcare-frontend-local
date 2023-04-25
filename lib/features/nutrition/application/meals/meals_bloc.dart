import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

part 'meals_event.dart';

part 'meals_state.dart';

part 'meals_bloc.freezed.dart';

@singleton
class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final NutritionService nutritionService;

  MealsBloc(this.nutritionService) : super(const MealsState.initial()) {
    on<FetchMeals>(_onFetchMeals);
    on<AddMeal>(_onAddMeal);
    on<AddFoodItemToMeal>(_onAddFoodItemToMeal);
    on<UpdateFoodItemInMeal>(_onUpdateFoodItemInMeal);
    on<DeleteMeal>(_onDeleteMeal);
    on<DeleteFoodItemFromMeal>(_onDeleteFoodItemFromMeal);
    on<DeleteRecipeFromMeal>(_onDeleteRecipeFromMeal);
    on<CreateFromFavorites>(_onCreateFromFavorites);
    on<SetMealId>(_onSetMealId);
    on<SetCurrentDate>(_onSetCurrentDate);
  }

  FutureOr<void> _onSetCurrentDate(
    SetCurrentDate event,
    Emitter<MealsState> emit,
  ) async {
    if (event.currentDate.isAfter(DateTime.now())) {
      emit(
        MealsState.meals(
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
            MealsState.meals(
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
      meals: (state) async {
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
          DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
    );

    response.fold(
      (error) {
        emit(MealsState.error(error));
      },
      (response) {
        emit(
          MealsState.meals(
            currentDate: DateTime.now(),
            meals: response.data.toIList(),
          ),
        );
      },
    );
  }

  FutureOr<void> _onCreateFromFavorites(
    CreateFromFavorites event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      meals: (state) async {
        final data = AddMealBody(
          loggingDate: DateTime.now().toIso8601String(),
          mealCategory: 'dinner',
        );

        final response = await nutritionService.addMeal(
          data,
        );

        await response.fold(
          (l) => null,
          (r) async {
            final mealId = r.id;
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

            final response2 = await nutritionService.addManyFoodItemsToMeal(
              mealId,
              manyFoodItemsListData,
            );

            response2.fold(
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
          },
        );
      },
    );
  }

  FutureOr<void> _onAddFoodItemToMeal(
    AddFoodItemToMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      meals: (state) async {
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

  FutureOr<void> _onUpdateFoodItemInMeal(
    UpdateFoodItemInMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      meals: (state) async {
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
    await state.mapOrNull(meals: (state) async {
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
    });
  }

  FutureOr<void> _onDeleteRecipeFromMeal(
    DeleteRecipeFromMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(meals: (state) async {
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
    });
  }

  FutureOr<void> _onDeleteMeal(
    DeleteMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      meals: (state) async {
        final response = await nutritionService.removeMeal(
          event.mealId,
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

  FutureOr<void> _onAddMeal(
    AddMeal event,
    Emitter<MealsState> emit,
  ) async {
    await state.mapOrNull(
      meals: (state) async {
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
            emit(
              state.copyWith(
                meals: (state.meals.toList()..add(r)).toIList(),
              ),
            );
          },
        );
      },
    );
  }

  IList<MealsListItem> _getUpdatedMealsList(MealsListItem mealItem) {
    return state.maybeMap(
      meals: (state) {
        return state.meals
            .toList()
            .map((e) => e.id == mealItem.id ? mealItem : e)
            .toIList();
      },
      orElse: () => <MealsListItem>[].toIList(),
    );
  }
}
