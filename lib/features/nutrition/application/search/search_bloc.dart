import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:dartz/dartz.dart' as dartz;

import '../../../../core/domain/recent_logged/recent_logged_item.dart';
import 'dto/search_response.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.freezed.dart';

part 'search_bloc.g.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NutritionService nutritionService;
  static const maxRecentLoggedListSize = 10;
  static const searchLimit = 20;
  late CancelToken cancelRequestToken;
  bool isPaginatedSearchRequestRun = false;

  SearchBloc(
    this.nutritionService,
  ) : super(const SearchState.initial(SearchData())) {
    on<Search>(_onSearch);
    on<PaginatedSearch>(
      _onPaginatedSearch,
      transformer: droppable(),
    );
    on<GetRecentLogged>(_onGetRecentLogged);
  }

  FutureOr<void> _onGetRecentLogged(
    GetRecentLogged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.getRecentLogged(
        event.category, event.mode.name, maxRecentLoggedListSize);

    response.fold(
        (l) => emit(SearchState.error(state.data.copyWith(error: l, isLoading: false))),
        (r) =>
            emit(SearchState.initial(state.data.copyWith(recentLogged: r.data, isLoading: false))));
  }

  Future<dartz.Either<RequestError, SearchResponse>> searchRequest(
    String query,
    String? filteredMode,
    String? mode,
    int? page,
    int? limit,
    CancelToken? cancelRequestToken,
  ) async {
    var eventLimit = limit ?? searchLimit;
    var searchMode = <String>[];

    if (mode != null && mode.isNotEmpty) {
      searchMode =
          mode == SearchMode.dish.name ? [SearchMode.dish.name, SearchMode.favorite.name] : [mode];
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
      cancelRequestToken: cancelRequestToken,
    );
  }

  FutureOr<void> _onSearch(
    Search event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.length < 3) return;

    if (isPaginatedSearchRequestRun) {
      cancelRequestToken.cancel(DioRequestCancellationReason.searchManualCancel);
      isPaginatedSearchRequestRun = false;
    }

    emit(SearchState.loading(state.data.copyWith(isLoading: true)));

    final response = await searchRequest(
      event.query,
      event.filteredMode,
      event.mode,
      event.page,
      event.limit,
      null,
    );

    response.fold(
      (error) {
        emit(SearchState.error(state.data.copyWith(error: error, isLoading: false)));
      },
      (response) {
        emit(
          SearchState.searchResult(
            state.data.copyWith(
              isLoading: false,
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
    cancelRequestToken = CancelToken();
    isPaginatedSearchRequestRun = true;

    final response = await searchRequest(
      event.query,
      event.filteredMode,
      event.mode,
      event.page,
      event.limit,
      cancelRequestToken,
    );

    response.fold(
      (error) {
        isPaginatedSearchRequestRun = false;
        emit(SearchState.error(state.data.copyWith(error: error)));
      },
      (response) {
        isPaginatedSearchRequestRun = false;
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
