import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_favorite_body.freezed.dart';

part 'update_favorite_body.g.dart';

@freezed
abstract class UpdateFavoriteBody implements _$UpdateFavoriteBody {
  const UpdateFavoriteBody._();

  const factory UpdateFavoriteBody({
    required List<String> mealCategories,
    required double? numberOfUnits,
  }) = _AUpdateFavoriteBody;

  factory UpdateFavoriteBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateFavoriteBodyFromJson(json);
}
