// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/recent_logged/recent_logged_item.dart';

part 'recent_logged_list.freezed.dart';

part 'recent_logged_list.g.dart';

@freezed
class RecentLoggedList with _$RecentLoggedList {
  factory RecentLoggedList({
    required List<RecentLoggedItem> data,
  }) = _RecentLoggedList;

  factory RecentLoggedList.fromJson(Map<String, dynamic> json) => _$RecentLoggedListFromJson(json);
}
