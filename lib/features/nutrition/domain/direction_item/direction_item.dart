import 'package:freezed_annotation/freezed_annotation.dart';

part 'direction_item.freezed.dart';

part 'direction_item.g.dart';

@freezed
abstract class DirectionItem implements _$DirectionItem {
  const DirectionItem._();

  const factory DirectionItem({
    required int number,
    required String description,
  }) = _DirectionItem;

  factory DirectionItem.fromJson(Map<String, dynamic> json) => _$DirectionItemFromJson(json);
}
