part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const SearchState._();

  const factory SearchState.initial({String? mode}) = _Initial;

  const factory SearchState.loading() = _Loading;

  const factory SearchState.error(RequestError fetchError) = _Error;

  const factory SearchState.searchResult({
    String? mode,
    required IList<SearchItem> items,
  }) = _SearchResult;
}
