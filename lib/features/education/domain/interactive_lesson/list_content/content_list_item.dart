import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_list_item.freezed.dart';
part 'content_list_item.g.dart';

@freezed
class ContentListItem with _$ContentListItem {
  const factory ContentListItem({
    required String label,
  }) = _ContentListItem;

  factory ContentListItem.fromJson(Map<String, dynamic> json) => _$ContentListItemFromJson(json);
}
