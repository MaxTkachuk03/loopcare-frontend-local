import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session_program_event.dart';

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
