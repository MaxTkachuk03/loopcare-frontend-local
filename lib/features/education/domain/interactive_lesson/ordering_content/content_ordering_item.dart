import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_ordering_item.freezed.dart';
part 'content_ordering_item.g.dart';

@freezed
class ContentOrderingItem with _$ContentOrderingItem {
  const factory ContentOrderingItem({
    required int id,
    required int correctIndex,
    required String src,
    required String title,
    required String description,
  }) = _ContentOrderingItem;

  factory ContentOrderingItem.fromJson(Map<String, dynamic> json) =>
      _$ContentOrderingItemFromJson(json);
}
