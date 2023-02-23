import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_prefer_gender.freezed.dart';

part 'update_prefer_gender.g.dart';

@freezed
abstract class UpdateUserPreferGender implements _$UpdateUserPreferGender {
  const UpdateUserPreferGender._();

  const factory UpdateUserPreferGender({
    required int id,
  }) = _UpdateUserPreferGender;

  factory UpdateUserPreferGender.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserPreferGenderFromJson(json);
}
