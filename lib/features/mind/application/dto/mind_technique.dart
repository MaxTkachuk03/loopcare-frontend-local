import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_content.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_unlock_style.dart';

part 'mind_technique.g.dart';

@immutable
@JsonSerializable()
class MindTechnique {
  final int id;
  final String title;
  final String image;
  final String subtitle;
  final String? shortIntroduction;
  final MindContent explanation;
  final bool isLocked;
  final DateTime? unlocksAt;
  final TechniqueExerciseUnlockStyle exerciseUnlockStyle;

  const MindTechnique({
    required this.id,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.shortIntroduction,
    required this.explanation,
    required this.isLocked,
    required this.unlocksAt,
    required this.exerciseUnlockStyle,
  });

  static MindTechnique fromJson(Map<String, dynamic> json) => _$MindTechniqueFromJson(json);

  Map<String, dynamic> toJson() => _$MindTechniqueToJson(this);
}
