part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const SearchState._();

  const factory SearchState.initial({
    @Default(<String>[]) List<String>? recentSearch,
  }) = _Initial;

  const factory SearchState.loading() = _Loading;

  const factory SearchState.error({
    @JsonKey(ignore: true) RequestError? fetchError,
  }) = _Error;

  const factory SearchState.searchResult({
    required IList<SearchItem> items,
    required SearchParameters searchParameters,
  }) = _SearchResult;

  factory SearchState.fromJson(Map<String, dynamic> json) => _$SearchStateFromJson(json);
}

@immutable
@JsonSerializable()
class SearchParameters {
  String? query;
  String? filteredMode;
  String? mode;
  int? page;
  int? limit;
  bool? isLastPage;

  SearchParameters(
    this.query, {
    this.filteredMode,
    this.mode,
    this.page,
    this.limit,
    this.isLastPage,
  });

  SearchParameters.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    filteredMode = json['filteredMode'];
    mode = json['mode'];
    page = json['page'];
    limit = json['limit'];
    isLastPage = json['isLastPage'];
  }
}
