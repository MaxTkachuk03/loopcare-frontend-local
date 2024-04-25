import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_explanation_type.dart';

part 'mind_content.g.dart';

@immutable
@JsonSerializable()
class MindContent {
  final int? duration;
  final String src;
  final String? preview;
  final String? question;
  final TechniqueExplanationType type;


  const MindContent({
    required this.duration,
    required this.src,
    required this.preview,
    required this.question,
    required this.type,
  });

  static MindContent fromJson(Map<String, dynamic> json) => _$MindContentFromJson(json);

  Map<String, dynamic> toJson() => _$MindContentToJson(this);
}