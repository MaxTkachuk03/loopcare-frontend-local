import 'package:freezed_annotation/freezed_annotation.dart';

part 'serving_type.freezed.dart';

part 'serving_type.g.dart';

@freezed
abstract class ServingType implements _$ServingType {
  const ServingType._();

  const factory ServingType({
    required int id,
    required String name,
    required String calories,
  }) = _ServingType;

  factory ServingType.fromJson(Map<String, dynamic> json) =>
      _$ServingTypeFromJson(json);
}
