import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/recent_search_user/recent_search_data.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:dartz/dartz.dart' as dartz;

import 'dto/search_response.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.freezed.dart';

part 'search_bloc.g.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AuthenticationCubit _authenticationCubit;
  final NutritionService nutritionService;
  final SharedStorageService _sharedStorageService;
  static const maxRecentSearchListSize = 10;
  static const searchLimit = 20;
  late CancelToken cancelRequestToken;
  bool isPaginatedSearchRequstRun = false;

  SearchBloc(
    this.nutritionService,
    this._authenticationCubit,
    this._sharedStorageService,
  ) : super(const SearchState.initial(SearchData())) {
    on<Search>(_onSearch);
    on<PaginatedSearch>(
      _onPaginatedSearch,
      transformer: droppable(),
    );
    on<ResetData>(_onResetData);
    on<AddSearchResult>(_onAddSearchResult);
  }

  FutureOr<void> _onAddSearchResult(
    AddSearchResult event,
    Emitter<SearchState> emit,
  ) {
    _addRecentSearch(event.query, event.mode);
  }

  Future<void> _addRecentSearch(String query, SearchMode type) async {
    final userId = _authenticationCubit.state.id;
    _sharedStorageService.findOrAddRecentUser(userId, RecentSearchData(type: type, query: query));
  }

  Future<List<String>> _getRecentSearch(bool needHeader, {SearchMode? type}) async {
    var list = <String>[];
    final userId = _authenticationCubit.state.id;
    List<String> savedList = _sharedStorageService.searchValues(userId, type: type);
    if (needHeader) {
      list.add('header');
    }
    list.addAll(savedList);
    return list;
  }

  Future<dartz.Either<RequestError, SearchResponse>> searchRequst(
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
      cancelRequestToken: cancelRequestToken,
    );
  }

  FutureOr<void> _onSearch(
    Search event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.length < 3) return;

    if (isPaginatedSearchRequstRun) {
      cancelRequestToken.cancel(DioRequestCancellationReason.searchManualCancel);
      isPaginatedSearchRequstRun = false;
    }

    emit(SearchState.loading(state.data.copyWith(isLoading: true)));

    final response = await searchRequst(
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
    isPaginatedSearchRequstRun = true;

    final response = await searchRequst(
      event.query,
      event.filteredMode,
      event.mode,
      event.page,
      event.limit,
      cancelRequestToken,
    );

    response.fold(
      (error) {
        isPaginatedSearchRequstRun = false;
        emit(SearchState.error(state.data.copyWith(error: error)));
      },
      (response) {
        isPaginatedSearchRequstRun = false;
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

  FutureOr<void> _onResetData(
    ResetData event,
    Emitter<SearchState> emit,
  ) async {
    final list = await _getRecentSearch(true, type: event.mode);
    emit(
      SearchState.initial(
        state.data.copyWith(
          recentSearch: list,
        ),
      ),
    );
  }
}
