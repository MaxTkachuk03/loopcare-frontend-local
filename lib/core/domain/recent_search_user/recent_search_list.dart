// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/recent_search_user/recent_search_data.dart';

part 'recent_search_list.freezed.dart';

part 'recent_search_list.g.dart';

@unfreezed
class RecentSearchList with _$RecentSearchList {
  factory RecentSearchList({
    required List<RecentSearchData> list,
  }) = _RecentSearchList;

  factory RecentSearchList.fromJson(Map<String, dynamic> json) => _$RecentSearchListFromJson(json);
}
