import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish/dish.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';

part 'dish_event.dart';
part 'dish_state.dart';
part 'dish_bloc.freezed.dart';

@singleton
class DishBloc extends Bloc<DishEvent, DishState> {
  final NutritionService nutritionService;

  DishBloc(this.nutritionService) : super(const DishState.initial()) {
    on<SetCurrentDish>(_onSetCurrentDish);
    on<NutritionItemChanged>(_onNutritionItemChanged);
  }

  FutureOr<void> _onSetCurrentDish(
    SetCurrentDish event,
    Emitter<DishState> emit,
  ) async {
    emit(const DishState.loading());

    emit(
      DishState.dish(
        selectedDish: event.dish,
        currentNutritionItem: event.dish.serving.list
            .firstWhere((e) => e.key == NutritionValuesTypes.calories.name),
      ),
    );
  }

  FutureOr<void> _onNutritionItemChanged(
    NutritionItemChanged event,
    Emitter<DishState> emit,
  ) async {
    state.mapOrNull(dish: (state) {
      emit(state.copyWith(currentNutritionItem: event.item));
    });
  }
}
