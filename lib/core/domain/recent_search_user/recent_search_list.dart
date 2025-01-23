// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_search_list.freezed.dart';

part 'recent_search_list.g.dart';

@freezed
class RecentSearchList with _$RecentSearchList {
  factory RecentSearchList({
    required List<String> data,
  }) = _RecentSearchList;

  factory RecentSearchList.fromJson(Map<String, dynamic> json) => _$RecentSearchListFromJson(json);
}
