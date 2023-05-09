part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const SearchState._();

  const factory SearchState.initial({
    @Default(<String>[]) List<String> recentSearch,
  }) = _Initial;

  const factory SearchState.loading() = _Loading;

  const factory SearchState.error({
    @JsonKey(ignore: true) RequestError? fetchError,
  }) = _Error;

  const factory SearchState.searchResult({
    required IList<SearchItem> items,
  }) = _SearchResult;

  factory SearchState.fromJson(Map<String, dynamic> json) =>
      _$SearchStateFromJson(json);
}
