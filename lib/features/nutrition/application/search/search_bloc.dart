import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart' as dartz;

import 'dto/search_response.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.freezed.dart';

part 'search_bloc.g.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NutritionService nutritionService;
  static const maxRecentSearchListSize = 10;
  static const searchLimit = 20;

  SearchBloc(this.nutritionService) : super(const SearchState.initial(SearchData())) {
    on<Search>(
      _onSearch,
      transformer: (events, mapper) => events
          .map((q) => q.copyWith(query: q.query.trim()))
          .distinct()
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<PaginatedSearch>(
      _onPaginatedSearch,
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

    var list = await _getRecentSearch(false);

    if (!list.contains(query)) {
      if (list.length > maxRecentSearchListSize - 1) {
        list.removeAt(maxRecentSearchListSize - 1);
      }
      list.insert(0, query);
    }

    prefs.setStringList('recent_search', list);
  }

  Future<List<String>> _getRecentSearch(bool needHeader) async {
    var list = <String>[];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? savedList = prefs.getStringList('recent_search');
    if (savedList != null) {
      if (needHeader) {
        list.add('header');
      }
      list.addAll(savedList);
    }

    return list;
  }

  Future<FutureOr<void>> _onResetData(
    ResetData event,
    Emitter<SearchState> emit,
  ) async {
    var list = await _getRecentSearch(true);
    emit(
      SearchState.initial(
        state.data.copyWith(
          recentSearch: list,
        ),
      ),
    );
  }

  Future<dartz.Either<RequestError, SearchResponse>> searchRequst(
      String query, String? filteredMode, String? mode, int? page, int? limit) async {
    var eventLimit = limit ?? searchLimit;
    var searchMode = <String>[];

    if (mode != null && mode.isNotEmpty && mode != 'all') {
      searchMode = <String>[mode];
    }
    if (filteredMode != null) {
      searchMode = [
        filteredMode,
        SearchMode.favorite.searchModeValue,
      ];
    }
    return await nutritionService.search(
      query,
      mode: searchMode,
      limit: eventLimit,
      page: page,
    );
  }

  FutureOr<void> _onSearch(
    Search event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.length < 3) {
      emit(
        SearchState.searchResult(
          state.data.copyWith(
            searchParameters: state.data.searchParameters.copyWith(
              isLastPage: false,
            ),
          ),
        ),
      );
      return;
    }

    final isLast = state.data.searchParameters.isLastPage ?? false;
    final prevMode = state.data.searchParameters.mode ?? '';
    if (isLast && prevMode == event.mode) return;

    final response = await searchRequst(
      event.query,
      event.filteredMode,
      event.mode,
      event.page,
      event.limit,
    );

    response.fold(
      (error) => emit(SearchState.error(state.data.copyWith(error: error))),
      (response) {
        emit(
          SearchState.searchResult(
            state.data.copyWith(
              items: response.data,
              searchParameters: SearchParameters(
                query: event.query,
                filteredMode: event.filteredMode,
                mode: event.mode,
                limit: event.limit,
                page: event.page,
                isLastPage: response.data.length != (event.limit ?? searchLimit),
              ),
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onPaginatedSearch(
    PaginatedSearch event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.length < 3) return;

    if (state.data.searchParameters.isLastPage ?? false) return;

    final oldItems = state.data.items;

    emit(SearchState.searchResult(state.data.copyWith(loadingMore: true)));

    final response = await searchRequst(
      event.query,
      event.filteredMode,
      event.mode,
      event.page,
      event.limit,
    );

    response.fold(
      (error) => emit(SearchState.error(state.data.copyWith(error: error))),
      (response) {
        final newItems = [...oldItems, ...response.data];
        emit(
          SearchState.searchResult(
            state.data.copyWith(
              loadingMore: false,
              items: newItems,
              searchParameters: SearchParameters(
                query: event.query,
                filteredMode: event.filteredMode,
                mode: event.mode,
                limit: event.limit,
                page: event.page,
                isLastPage: response.data.length != (event.limit ?? searchLimit),
              ),
            ),
          ),
        );
      },
    );
  }
}
