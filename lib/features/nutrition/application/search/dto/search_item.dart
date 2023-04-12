import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_item.freezed.dart';
part 'search_item.g.dart';

@freezed
class SearchItem with _$SearchItem {
  const factory SearchItem({
    required String id,
    required String name,
    required String type,
  }) = _SearchItem;

  factory SearchItem.fromJson(Map<String, dynamic> json) =>
      _$SearchItemFromJson(json);
}
