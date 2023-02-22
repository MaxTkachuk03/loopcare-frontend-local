import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_prefer_gender.freezed.dart';

part 'update_prefer_gender.g.dart';

@freezed
abstract class UpdatePreferGender implements _$UpdateUserDiabetes {
  const UpdatePreferGender._();

  const factory UpdatePreferGender({
    required int id,
  }) = _UpdatePreferGender;

  factory UpdatePreferGender.fromJson(Map<String, dynamic> json) =>
      _$UpdatePreferGenderFromJson(json);
}
