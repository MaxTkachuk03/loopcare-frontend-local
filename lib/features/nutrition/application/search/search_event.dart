part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.resetData() = ResetData;

  const factory SearchEvent.search(
    String query, {
    String? mode,
    int? limit,
  }) = Search;

  const factory SearchEvent.setSearchMode(String? mode) = SetSearchMode;
}
