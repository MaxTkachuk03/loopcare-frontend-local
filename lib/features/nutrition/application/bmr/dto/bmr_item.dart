import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmr_item.freezed.dart';

part 'bmr_item.g.dart';

@freezed
class BmrItem with _$BmrItem {
  const factory BmrItem({
    required double bmr,
  }) = _BmrItem;

  factory BmrItem.fromJson(Map<String, dynamic> json) => _$BmrItemFromJson(json);
}
