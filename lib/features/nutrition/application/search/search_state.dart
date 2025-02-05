part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial(SearchData data) = _Initial;

  const factory SearchState.loading(SearchData data) = _Loading;

  const factory SearchState.error(SearchData data) = _Error;

  const factory SearchState.searchResult(SearchData data) = _SearchResult;
}

@freezed
class SearchData with _$SearchData {
  const SearchData._();

  const factory SearchData({
    @Default([]) List<RecentLoggedItem> recentLogged,
    @Default(<SearchItem>[]) List<SearchItem> items,
    @Default(SearchParameters()) SearchParameters searchParameters,
    @Default(false) bool loadingMore,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _SearchData;
}

@freezed
class SearchParameters with _$SearchParameters {
  const SearchParameters._();

  const factory SearchParameters({
    @Default('') String? query,
    @Default('') String? filteredMode,
    @Default('') String? mode,
    @Default(null) int? page,
    @Default(null) int? limit,
    @Default(false) bool? isLastPage,
  }) = _SearchParameters;

  factory SearchParameters.fromJson(Map<String, dynamic> json) =>
      _$SearchParametersFromJson(json);
}
