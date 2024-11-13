import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_to_favorites_body.freezed.dart';

part 'add_to_favorites_body.g.dart';

@freezed
abstract class AddToFavoritesBody implements _$AddToFavoritesBody {
  const AddToFavoritesBody._();

  const factory AddToFavoritesBody({
    required double? numberOfUnits,
    required List<String> mealCategories,
  }) = _AddToFavoritesBody;

  factory AddToFavoritesBody.fromJson(Map<String, dynamic> json) =>
      _$AddToFavoritesBodyFromJson(json);
}
