import 'package:freezed_annotation/freezed_annotation.dart';

part 'prefer_gender.freezed.dart';

part 'prefer_gender.g.dart';

@freezed
abstract class PreferGender implements _$PreferGender {
  const PreferGender._();

  const factory PreferGender({
    required int id,
    required String name,
  }) = _PreferGender;

  factory PreferGender.fromJson(Map<String, dynamic> json) =>
      _$PreferGenderFromJson(json);
}
