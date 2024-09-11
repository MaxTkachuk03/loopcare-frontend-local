import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/account/domain/food_preference_service.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_preference.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_prefs_data.dart';

part 'food_preference_bloc.freezed.dart';
part 'food_preference_event.dart';
part 'food_preference_state.dart';

@singleton
class FoodPreferenceBloc extends Bloc<FoodPreferenceEvent, FoodPreferenceState> {
  final FoodPreferenceService foodPreferenceService;

  FoodPreferenceBloc(this.foodPreferenceService)
      : super(const FoodPreferenceState.initial(FoodPreferenceData())) {
    on<FetchFoodPrefsTypes>(_onFetchFoodPrefsTypes);
    on<FoodPrefsPeriods>(_onFoodPrefsPeriods);
    on<FoodPrefsDislikes>(_onFoodPrefsDislikes);
    on<FoodPrefsAllergens>(_onFoodPrefsAllergens);
    on<SetHates>(_onSetHates);
    on<SetAllergic>(_onSetAllergic);
    on<SetDislike>(_onSetDislike);
    on<SaveFoodPreferences>(_onSaveFoodPreferences);
    on<FetchFoodPreferences>(_onFetchFoodPreferences);
    on<SetInitialFoodPreferences>(_onSetInitialFoodPreferences);
  }

  FutureOr<void> _onFetchFoodPrefsTypes(
    FetchFoodPrefsTypes event,
    Emitter<FoodPreferenceState> emit,
  ) async {
    emit(FoodPreferenceState.loading(state.data.copyWith(isLoading: true)));

    final response = await foodPreferenceService.foodPrefsHates();

    response.fold(
      (l) => emit(FoodPreferenceState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        FoodPreferenceState.loaded(
          state.data.copyWith(isLoading: false, foodTypes: r.data),
        ),
      ),
    );
  }

  FutureOr<void> _onFoodPrefsPeriods(
    FoodPrefsPeriods event,
    Emitter<FoodPreferenceState> emit,
  ) async {
    emit(FoodPreferenceState.loading(state.data.copyWith(isLoading: true)));

    final response = await foodPreferenceService.foodPrefsPeriods();

    response.fold(
      (l) => emit(FoodPreferenceState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        FoodPreferenceState.loaded(
          state.data.copyWith(isLoading: false, foodPeriods: r.data),
        ),
      ),
    );
  }

  FutureOr<void> _onFoodPrefsAllergens(
    FoodPrefsAllergens event,
    Emitter<FoodPreferenceState> emit,
  ) async {
    emit(FoodPreferenceState.loading(state.data.copyWith(isLoading: true)));

    final response = await foodPreferenceService.foodPrefsAllergens();

    response.fold(
      (l) => emit(FoodPreferenceState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        FoodPreferenceState.loaded(
          state.data.copyWith(isLoading: false, foodAllergens: r.data),
        ),
      ),
    );
  }

  FutureOr<void> _onFoodPrefsDislikes(
    FoodPrefsDislikes event,
    Emitter<FoodPreferenceState> emit,
  ) async {
    emit(FoodPreferenceState.loading(state.data.copyWith(isLoading: true)));

    final response = await foodPreferenceService.foodPrefsDislikes();

    response.fold(
      (l) => emit(FoodPreferenceState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) => emit(
        FoodPreferenceState.loaded(
          state.data.copyWith(isLoading: false, foodDislikes: r.data),
        ),
      ),
    );
  }

  FutureOr<void> _onSetInitialFoodPreferences(
    SetInitialFoodPreferences event,
    Emitter<FoodPreferenceState> emit,
  ) {
    emit(
      FoodPreferenceState.loaded(
        state.data.copyWith(
          selectedHates: event.hates,
          selectedAllergic: event.allergics,
          selectedDislike: event.dislikes,
        ),
      ),
    );
  }

  FutureOr<void> _onSetHates(
    SetHates event,
    Emitter<FoodPreferenceState> emit,
  ) {
    final selectedHates = List.of(state.data.selectedHates);

    if (selectedHates.contains(event.value)) {
      selectedHates.remove(event.value);
    } else {
      selectedHates.add(event.value);
    }

    final selectedPeriod = state.data.userDoesNotEatMeat && state.data.userDoesNotEatFish
        ? null
        : state.data.selectedPeriod;

    emit(
      FoodPreferenceState.loaded(
        state.data.copyWith(
          selectedHates: selectedHates,
          selectedPeriod: selectedPeriod,
        ),
      ),
    );
  }

  FutureOr<void> _onSetAllergic(
    SetAllergic event,
    Emitter<FoodPreferenceState> emit,
  ) {
    final selectedAllergic = List.of(state.data.selectedAllergic);

    if (selectedAllergic.contains(event.value)) {
      selectedAllergic.remove(event.value);
    } else {
      selectedAllergic.add(event.value);
    }

    emit(
      FoodPreferenceState.loaded(
        state.data.copyWith(
          selectedAllergic: selectedAllergic,
        ),
      ),
    );
  }

  FutureOr<void> _onSetDislike(
    SetDislike event,
    Emitter<FoodPreferenceState> emit,
  ) {
    final selectedDislike = List.of(state.data.selectedDislike);

    if (selectedDislike.contains(event.value)) {
      selectedDislike.remove(event.value);
    } else {
      selectedDislike.add(event.value);
    }

    emit(
      FoodPreferenceState.loaded(
        state.data.copyWith(
          selectedDislike: selectedDislike,
        ),
      ),
    );
  }

  FutureOr<void> _onSaveFoodPreferences(
    SaveFoodPreferences event,
    Emitter<FoodPreferenceState> emit,
  ) async {
    emit(FoodPreferenceState.loading(state.data.copyWith(isLoading: true, saved: false)));

    final data = FoodPrefsData(
      hates: state.data.selectedHatesIds,
      allergic: state.data.selectedAllergicIds,
      dislike: state.data.selectedDislikesIds,
      period: state.data.selectedPeriod,
    );

    final response = await foodPreferenceService.foodPrefsSave(data);

    response.fold(
      (l) => emit(
        FoodPreferenceState.error(
          state.data.copyWith(
            error: l,
            isLoading: false,
            isCompleted: false,
          ),
        ),
      ),
      (r) => emit(
        FoodPreferenceState.error(
          state.data.copyWith(
            saved: true,
            isLoading: true,
            isCompleted: false,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onFetchFoodPreferences(
    FetchFoodPreferences event,
    Emitter<FoodPreferenceState> emit,
  ) async {
    emit(FoodPreferenceState.loading(state.data.copyWith(isLoading: true)));

    final response = await foodPreferenceService.foodPrefsFetch();

    response.fold(
      (l) {
        l.maybeMap(
          notFound: (_) => emit(
            FoodPreferenceState.loaded(
              state.data.copyWith(
                isLoading: false,
                isCompleted: false,
                selectedHates: [],
                selectedAllergic: [],
                selectedDislike: [],
              ),
            ),
          ),
          orElse: () => emit(
            FoodPreferenceState.error(
              state.data.copyWith(
                error: l,
                isLoading: false,
                isCompleted: false,
              ),
            ),
          ),
        );
      },
      (response) => emit(
        FoodPreferenceState.loaded(
          state.data.copyWith(
            isLoading: false,
            isCompleted: true,
            selectedHates: response.hates ?? [],
            selectedAllergic: response.allergic ?? [],
            selectedDislike: response.dislike ?? [],
            selectedPeriod: response.period,
          ),
        ),
      ),
    );
  }
}
