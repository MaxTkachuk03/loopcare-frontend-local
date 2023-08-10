import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';

part 'search_item.freezed.dart';
part 'search_item.g.dart';

@freezed
class SearchItem with _$SearchItem {
  const factory SearchItem({
    required String id,
    required String name,
    String? image,
    required SearchItemTypes type,
  }) = _SearchItem;

  factory SearchItem.fromJson(Map<String, dynamic> json) => _$SearchItemFromJson(json);
}
