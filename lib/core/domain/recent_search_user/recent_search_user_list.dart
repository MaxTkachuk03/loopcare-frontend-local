// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/recent_search_user/recent_search_user.dart';

part 'recent_search_user_list.freezed.dart';

part 'recent_search_user_list.g.dart';

@unfreezed
class RecentSearchUserList with _$RecentSearchUserList {
  factory RecentSearchUserList({
    required List<RecentSearchUser> users,
  }) = _RecentSearchUserList;

  factory RecentSearchUserList.fromJson(Map<String, dynamic> json) =>
      _$RecentSearchUserListFromJson(json);
}
