import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_content.dart';

part 'mind_info_response.g.dart';

@immutable
@JsonSerializable()
class MindInfoResponse {
  final String title;
  final String subtitle;
  final String shortIntroduction;
  final MindContent explanation;

  const MindInfoResponse({
    required this.title,
    required this.subtitle,
    required this.shortIntroduction,
    required this.explanation,
  });

  static MindInfoResponse fromJson(Map<String, dynamic> json) => _$MindInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MindInfoResponseToJson(this);
}
