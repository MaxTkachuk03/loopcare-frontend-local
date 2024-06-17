import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique.dart';

part 'mind_techniques_response.g.dart';

@immutable
@JsonSerializable()
class MindTechniquesResponse {
  final List<MindTechnique> data;

  const MindTechniquesResponse(this.data);

  static MindTechniquesResponse fromJson(Map<String, dynamic> json) => _$MindTechniquesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MindTechniquesResponseToJson(this);
}
