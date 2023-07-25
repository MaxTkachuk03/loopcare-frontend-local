import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';

part 'favorites_item.freezed.dart';

part 'favorites_item.g.dart';

@freezed
abstract class FavoritesItem implements _$FavoritesItem {
  const FavoritesItem._();

  const factory FavoritesItem({
    required String id,
    required String foodName,
    required String foodType,
    required String? brandName,
    required String? foodDescription,
    required ServingSize serving,
  }) = _FavoritesItem;

  factory FavoritesItem.fromJson(Map<String, dynamic> json) =>
      _$FavoritesItemFromJson(json);
}
