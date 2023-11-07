// Package imports:

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/recent_search_user/recent_search_list.dart';

part 'recent_search_user.freezed.dart';

part 'recent_search_user.g.dart';

@unfreezed
abstract class RecentSearchUser with _$RecentSearchUser {
   factory RecentSearchUser({
     required int id,
     required  RecentSearchList data,
   }
  ) = _RecentSearchUser;

  factory RecentSearchUser.fromJson(Map<String, dynamic> json) => _$RecentSearchUserFromJson(json);
}
