import 'package:freezed_annotation/freezed_annotation.dart';

part 'eat_place_item.freezed.dart';

part 'eat_place_item.g.dart';

@freezed
abstract class EatPlaceItem implements _$EatPlaceItem {
  const EatPlaceItem._();

  const factory EatPlaceItem({
    required int id,
    required String name,
  }) = _EatPlaceItem;

  factory EatPlaceItem.fromJson(Map<String, dynamic> json) =>
      _$EatPlaceItemFromJson(json);
}
