import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_account_diabetes.freezed.dart';

part 'add_account_diabetes.g.dart';

@freezed
abstract class AddAccountDiabetes implements _$AddAccountDiabetes {
  const AddAccountDiabetes._();

  const factory AddAccountDiabetes({
    required int id,
  }) = _AddAccountDiabetes;

  factory AddAccountDiabetes.fromJson(Map<String, dynamic> json) =>
      _$AddAccountDiabetesFromJson(json);
}
