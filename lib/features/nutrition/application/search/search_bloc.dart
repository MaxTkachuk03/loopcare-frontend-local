import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.freezed.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NutritionService nutritionService;

  SearchBloc(this.nutritionService) : super(const SearchState.initial()) {
    on<Search>(
      _onSearch,
      transformer: (events, mapper) => events
          .map((q) => q.copyWith(query: q.query.trim()))
          .distinct()
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<ResetData>(_onResetData);
  }

  FutureOr<void> _onResetData(
    ResetData event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchState.initial());
  }

  FutureOr<void> _onSearch(
    Search event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.length < 3) return;

    emit(const SearchState.loading());

    var eventMode = event.mode;
    var eventFilteredMode = event.filteredMode;
    var searchMode = <String>[];

    if (eventMode != null) {
      searchMode = <String>[eventMode];
    }
    if (eventFilteredMode != null) {
      searchMode = [
        eventFilteredMode,
        SearchMode.favorite.searchModeValue,
      ];
    }

    final response = await nutritionService.search(
      event.query,
      mode: searchMode,
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
          ),
        );
      },
    );
  }
}
