import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_prefs_data.dart';
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
    on<FoodPrefsDislikes>(_onFoodPrefsDislikes);
    on<FoodPrefsAllergens>(_onFoodPrefsAllergens);
    on<SetHates>(_onSetHates);
    on<SetPeriod>(_onSetPeriod);
    on<SetAllergic>(_onSetAllergic);
    on<SetDislike>(_onSetDislike);
    on<SaveFoodPreferences>(_onSaveFoodPreferences);
    on<FetchFoodPreferences>(_onFetchFoodPreferences);
  }

  FutureOr<void> _onFetchFoodPrefsTypes(
    FetchFoodPrefsTypes event,
    Emitter<YouAndFoodState> emit,
  ) async {
    final response = await youAndFoodService.foodPrefsHates();

    response.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(foodTypes: r.data),
      ),
    );
  }

  FutureOr<void> _onFoodPrefsPeriods(
    FoodPrefsPeriods event,
    Emitter<YouAndFoodState> emit,
  ) async {
    final response = await youAndFoodService.foodPrefsPeriods();

    response.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(foodPeriods: r.data),
      ),
    );
  }

  FutureOr<void> _onFoodPrefsAllergens(
    FoodPrefsAllergens event,
    Emitter<YouAndFoodState> emit,
  ) async {
    final response = await youAndFoodService.foodPrefsAllergens();

    response.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(foodAllergens: r.data),
      ),
    );
  }

  FutureOr<void> _onFoodPrefsDislikes(
    FoodPrefsDislikes event,
    Emitter<YouAndFoodState> emit,
  ) async {
    final response = await youAndFoodService.foodPrefsDislikes();

    response.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(foodDislikes: r.data),
      ),
    );
  }

  FutureOr<void> _onSetHates(
    SetHates event,
    Emitter<YouAndFoodState> emit,
  ) {
    emit(state.copyWith(
        selectedHates: state.selectedHates.contains(event.value)
            ? state.selectedHates.remove(event.value)
            : state.selectedHates.add(event.value)));

    if (state.userDoesNotEatMeat && state.userDoesNotEatFish) {
      emit(state.copyWith(selectedPeriod: null));
    }
  }

  FutureOr<void> _onSetAllergic(
    SetAllergic event,
    Emitter<YouAndFoodState> emit,
  ) {
    emit(state.copyWith(
        selectedAllergic: state.selectedAllergic.contains(event.value)
            ? state.selectedAllergic.remove(event.value)
            : state.selectedAllergic.add(event.value)));
  }

  FutureOr<void> _onSetDislike(
    SetDislike event,
    Emitter<YouAndFoodState> emit,
  ) {
    emit(state.copyWith(
        selectedDislike: state.selectedDislike.contains(event.value)
            ? state.selectedDislike.remove(event.value)
            : state.selectedDislike.add(event.value)));
  }

  FutureOr<void> _onSetPeriod(SetPeriod event, Emitter<YouAndFoodState> emit) {
    emit(state.copyWith(selectedPeriod: event.value));
  }

  FutureOr<void> _onSaveFoodPreferences(
    SaveFoodPreferences event,
    Emitter<YouAndFoodState> emit,
  ) async {
    emit(state.copyWith(isCompleted: true));

    final data = FoodPrefsData(
      hates: state.selectedHates,
      allergic: state.selectedAllergic,
      dislike: state.selectedDislike,
      period: state.selectedPeriod,
    );

    youAndFoodService.foodPrefsSave(data);
  }

  FutureOr<void> _onFetchFoodPreferences(
    FetchFoodPreferences event,
    Emitter<YouAndFoodState> emit,
  ) async {
    final response = await youAndFoodService.foodPrefsFetch();

    response.fold((l) {
      l.mapOrNull(notFound: (_) => emit(state.copyWith(isCompleted: false)));
    },
        (response) => emit(state.copyWith(
              selectedHates: response.hates ?? <int>[].toIList(),
              selectedAllergic: response.allergic ?? <int>[].toIList(),
              selectedDislike: response.dislike ?? <int>[].toIList(),
              selectedPeriod: response.period,
              isCompleted: true,
            )));
  }
}
