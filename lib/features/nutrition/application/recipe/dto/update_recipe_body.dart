import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_recipe_body.freezed.dart';

part 'update_recipe_body.g.dart';

@freezed
abstract class UpdateRecipeBody implements _$UpdateRecipeBody {
  const UpdateRecipeBody._();

  const factory UpdateRecipeBody({
    required double numberOfUnits,
  }) = _UpdateRecipeBody;

  factory UpdateRecipeBody.fromJson(Map<String, dynamic> json) => _$UpdateRecipeBodyFromJson(json);
}
