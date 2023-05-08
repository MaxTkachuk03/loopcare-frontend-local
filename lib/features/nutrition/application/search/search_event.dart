part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.resetData() = ResetData;

  const factory SearchEvent.search(
    String query, {
    String? filteredMode,
    String? mode,
    int? limit,
  }) = Search;
}
