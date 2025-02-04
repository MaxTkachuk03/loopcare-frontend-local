// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_logged_list.freezed.dart';

part 'recent_logged_list.g.dart';

@freezed
class RecentLoggedList with _$RecentLoggedList {
  factory RecentLoggedList({
    required List<String> data,
  }) = _RecentLoggedList;

  factory RecentLoggedList.fromJson(Map<String, dynamic> json) => _$RecentLoggedListFromJson(json);
}
