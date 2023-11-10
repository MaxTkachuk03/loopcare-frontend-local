import 'package:freezed_annotation/freezed_annotation.dart';

part 'material.freezed.dart';

part 'material.g.dart';

@freezed
class Material with _$Material {
  const Material._();

  const factory Material({
    required String article,
    required int id,
  }) = _Material;

  factory Material.fromJson(Map<String, dynamic> json) => _$MaterialFromJson(json);
}
