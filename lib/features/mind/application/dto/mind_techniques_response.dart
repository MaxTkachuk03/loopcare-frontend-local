import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_content.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique.dart';

part 'mind_techniques_response.g.dart';

@immutable
@JsonSerializable()
class MindTechniquesResponse {
  final String title;
  final String subtitle;
  final String shortIntroduction;
  final MindContent explanation;
  final List<MindTechnique> techniques;

  const MindTechniquesResponse({
    required this.title,
    required this.subtitle,
    required this.shortIntroduction,
    required this.explanation,
    required this.techniques,
  });

  static MindTechniquesResponse fromJson(Map<String, dynamic> json) =>
      _$MindTechniquesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MindTechniquesResponseToJson(this);
}
