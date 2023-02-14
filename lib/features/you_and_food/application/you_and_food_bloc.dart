import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_service.dart';

part 'you_and_food_bloc.freezed.dart';

part 'you_and_food_event.dart';

part 'you_and_food_state.dart';

@singleton
class YouAndFoodBloc extends Bloc<YouAndFoodEvent, YouAndFoodState> {
  final YouAndFoodService youAndFoodService;

  YouAndFoodBloc(this.youAndFoodService) : super(YouAndFoodState.initial()) {
    on<FetchFoodPrefsTypes>(_onFetchFoodPrefsTypes);
    on<FoodPrefsPeriods>(_onFoodPrefsPeriods);
    on<FoodPrefsItems>(_onFoodPrefsItems);
    on<SetHates>(_onSetHates);
    on<SetPeriod>(_onSetPeriod);
    on<SetAllergic>(_onSetAllergic);
    on<SetDislike>(_onSetDislike);
  }

  FutureOr<void> _onFetchFoodPrefsTypes(
    FetchFoodPrefsTypes event,
    Emitter<YouAndFoodState> emit,
  ) async {
    emit(
      state.copyWith(
          foodTypes: [
        FoodPreference(id: 1, name: 'Test1'),
        FoodPreference(id: 2, name: 'Test2'),
        FoodPreference(id: 3, name: 'Test3'),
      ].toIList()),
    );
    // final response = await youAndFoodService.foodPrefsTypes();
    //
    // response.fold(
    //   (l) => null,
    //   (r) => emit(
    //     // state.copyWith(foodTypes: r.preferences),
    //   ),
    // );
  }

  FutureOr<void> _onFoodPrefsPeriods(
    FoodPrefsPeriods event,
    Emitter<YouAndFoodState> emit,
  ) async {
    emit(
      state.copyWith(
          foodPeriods: [
        FoodPreference(id: 4, name: 'Test4'),
        FoodPreference(id: 5, name: 'Test5'),
        FoodPreference(id: 6, name: 'Test6'),
      ].toIList()),
    );
    // final response = await youAndFoodService.foodPrefsPeriods();
    //
    // response.fold(
    //   (l) => null,
    //   (r) => emit(
    //     // state.copyWith(foodPeriods: r.preferences),
    //   ),
    // );
  }

  FutureOr<void> _onFoodPrefsItems(
    FoodPrefsItems event,
    Emitter<YouAndFoodState> emit,
  ) async {
    emit(
      state.copyWith(
          foodItems: [
        FoodPreference(id: 7, name: 'Test7'),
        FoodPreference(id: 8, name: 'Test8'),
        FoodPreference(id: 9, name: 'Test9'),
      ].toIList()),
    );
    // final response = await youAndFoodService.foodPrefsItems();
    //
    // response.fold(
    //   (l) => null,
    //   (r) => emit(
    //     // state.copyWith(foodItems: r.preferences),
    //   ),
    // );
  }

  FutureOr<void> _onSetHates(
    SetHates event,
    Emitter<YouAndFoodState> emit,
  ) {
    final selectedHates = state.selectedHates ?? <int>[].toIList();

    emit(state.copyWith(
        selectedHates: selectedHates.contains(event.value)
            ? selectedHates.remove(event.value)
            : selectedHates.add(event.value)));
  }

  FutureOr<void> _onSetAllergic(
    SetAllergic event,
    Emitter<YouAndFoodState> emit,
  ) {
    final selectedAllergic = state.selectedAllergic ?? <int>[].toIList();

    emit(state.copyWith(
        selectedAllergic: selectedAllergic.contains(event.value)
            ? selectedAllergic.remove(event.value)
            : selectedAllergic.add(event.value)));
  }

  FutureOr<void> _onSetDislike(
    SetDislike event,
    Emitter<YouAndFoodState> emit,
  ) {
    final selectedDislike = state.selectedDislike ?? <int>[].toIList();

    emit(state.copyWith(
        selectedDislike: selectedDislike.contains(event.value)
            ? selectedDislike.remove(event.value)
            : selectedDislike.add(event.value)));
  }

  FutureOr<void> _onSetPeriod(SetPeriod event, Emitter<YouAndFoodState> emit) {
    emit(state.copyWith(selectedPeriod: event.value));
  }
}
