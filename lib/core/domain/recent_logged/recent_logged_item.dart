// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_logged_item.freezed.dart';

part 'recent_logged_item.g.dart';

@freezed
class RecentLoggedItem with _$RecentLoggedItem {
  factory RecentLoggedItem({
    required int mealId,
    required int mealItemId,
    required String name,
    required String type,
    required String? itemExternalId,
    required String servingId,
    required int numberOfUnits,
    required int calories,
  }) = _RecentLoggedItem;

  factory RecentLoggedItem.fromJson(Map<String, dynamic> json) => _$RecentLoggedItemFromJson(json);
}
