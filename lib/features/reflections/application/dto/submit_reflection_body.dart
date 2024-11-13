import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_reflection_body.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class SubmitReflectionBody {
  final int reflectionQuestionId;
  final List<int>? reflectionQuestionOptionIds;
  final String? text;
  final int? value;

  const SubmitReflectionBody({
    required this.reflectionQuestionId,
    this.reflectionQuestionOptionIds,
    this.text,
    this.value,
  });

  factory SubmitReflectionBody.fromJson(Map<String, dynamic> json) =>
      _$SubmitReflectionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitReflectionBodyToJson(this);
}
