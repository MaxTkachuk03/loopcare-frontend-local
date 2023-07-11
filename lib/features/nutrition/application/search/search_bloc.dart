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
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.freezed.dart';

part 'search_bloc.g.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NutritionService nutritionService;
  static const maxRecentSearchListSize = 10;

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
    on<AddSearchResult>(_onAddSearchResult);
  }

  FutureOr<void> _onAddSearchResult(
    AddSearchResult event,
    Emitter<SearchState> emit,
  ) {
    _addRecentSearch(event.query);
  }

  Future<void> _addRecentSearch(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var list = await _getRecentSearch();

    if (!list.contains(query)) {
      if (list.length > maxRecentSearchListSize - 1) {
        list.removeAt(maxRecentSearchListSize - 1);
      }
      list.insert(0, query);
    }

    prefs.setStringList('recent_search', list);
  }

  Future<List<String>> _getRecentSearch() async {
    var list = <String>[];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? savedList = prefs.getStringList('recent_search');
    if (savedList != null) {
      list.addAll(savedList);
    }

    return list;
  }

  Future<FutureOr<void>> _onResetData(
    ResetData event,
    Emitter<SearchState> emit,
  ) async {
    var list = await _getRecentSearch();
    emit(
      SearchState.initial(
        recentSearch: list,
      ),
    );
  }

  FutureOr<void> _onSearch(
    Search event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.length < 3) return;

    final isLast = state.mapOrNull(searchResult: (s) => s.searchParameters.isLastPage) ?? false;
    if (isLast) return;

    final oldItems = state.mapOrNull(searchResult: (s) => s.items.toList());

    var limit = event.limit ?? 10;
    var eventMode = event.mode;
    var eventFilteredMode = event.filteredMode;
    var searchMode = <String>[];

    if (eventMode != null && eventMode.isNotEmpty && eventMode != 'all') {
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
      limit: limit,
      page: event.page,
    );

    response.fold(
      (error) => emit(SearchState.error(fetchError: error)),
      (response) {
        final newItems = oldItems != null ? [...oldItems, ...response.data] : response.data;

        emit(
          SearchState.searchResult(
            items: newItems.toIList(),
            searchParameters: SearchParameters(event.query,
                filteredMode: event.filteredMode,
                mode: event.mode,
                limit: limit,
                page: event.page,
                isLastPage: response.data.length != limit),
          ),
        );
      },
    );
  }
}
