import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_item.freezed.dart';
part 'action_item.g.dart';

@freezed
class ActionItem with _$ActionItem {
  const factory ActionItem({
    int? times,
    required int? identifier,
    required String? actionType,
    required String? module,
    required int? id,
  }) = _ActionItem;

  factory ActionItem.fromJson(Map<String, dynamic> json) => _$ActionItemFromJson(json);
}
