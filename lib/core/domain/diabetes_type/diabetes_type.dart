import 'package:freezed_annotation/freezed_annotation.dart';

part 'diabetes_type.freezed.dart';
part 'diabetes_type.g.dart';

@freezed
abstract class DiabetesType implements _$DiabetesType {
  const DiabetesType._();

  const factory DiabetesType({
    required int id,
    required String name,
  }) = _DiabetesType;

  factory DiabetesType.fromJson(Map<String, dynamic> json) => _$DiabetesTypeFromJson(json);
}
