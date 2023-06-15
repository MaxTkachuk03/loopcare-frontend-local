import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

part 'program_list_response.g.dart';

@immutable
@JsonSerializable()
class ProgramListResponse {
  final List<PhysicalProgram> data;

  const ProgramListResponse({
    required this.data,
  });

  static ProgramListResponse fromJson(Map<String, dynamic> json) =>
      _$ProgramListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramListResponseToJson(this);
}
