import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.freezed.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NutritionService nutritionService;

  SearchBloc(this.nutritionService) : super(const SearchState.initial()) {
    on<Search>(_onSearch);
    on<SetSearchMode>(_onSetSearchMode);
  }

  FutureOr<void> _onSetSearchMode(
    SetSearchMode event,
    Emitter<SearchState> emit,
  ) async {
    state.mapOrNull(
      initial: (state) => emit(
        state.copyWith(
          mode: event.mode,
        ),
      ),
      searchResult: (state) => emit(
        state.copyWith(
          mode: event.mode,
        ),
      ),
    );
  }

  FutureOr<void> _onSearch(
    Search event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.length < 3) return;

    // final mode = state.mapOrNull(searchResult: (s) => s.mode);
    emit(const SearchState.loading());

    final response = await nutritionService.search(
      event.query,
      mode: event.mode,
      limit: event.limit,
    );

    response.fold(
      (error) {
        emit(SearchState.error(error));
      },
      (response) {
        emit(
          SearchState.searchResult(
            items: response.data.toIList(),
            mode: event.mode,
          ),
        );
      },
    );
  }
}
