part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.getRecentLogged(String category, SearchMode mode) = GetRecentLogged;

  const factory SearchEvent.search(
    String query, {
    String? filteredMode,
    String? mode,
    int? page,
    int? limit,
  }) = Search;

  const factory SearchEvent.paginatedSearch(
    String query, {
    String? filteredMode,
    String? mode,
    int? page,
    int? limit,
  }) = PaginatedSearch;
}
