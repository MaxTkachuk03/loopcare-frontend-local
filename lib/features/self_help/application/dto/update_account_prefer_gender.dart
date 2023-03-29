import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_account_prefer_gender.freezed.dart';

part 'update_account_prefer_gender.g.dart';

@freezed
abstract class UpdateAccountPreferGender implements _$UpdateAccountPreferGender {
  const UpdateAccountPreferGender._();

  const factory UpdateAccountPreferGender({
    required int id,
  }) = _UpdateAccountPreferGender;

  factory UpdateAccountPreferGender.fromJson(Map<String, dynamic> json) =>
      _$UpdateAccountPreferGenderFromJson(json);
}
