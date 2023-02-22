import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_user_diabetes.freezed.dart';

part 'add_user_diabetes.g.dart';

@freezed
abstract class AddUserDiabetes implements _$AddUserDiabetes {
  const AddUserDiabetes._();

  const factory AddUserDiabetes({
    required int id,
  }) = _AddUserDiabetes;

  factory AddUserDiabetes.fromJson(Map<String, dynamic> json) =>
      _$AddUserDiabetesFromJson(json);
}
