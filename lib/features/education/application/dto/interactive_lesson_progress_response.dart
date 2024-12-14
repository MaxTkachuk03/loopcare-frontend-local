import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interactive_lesson_progress_response.g.dart';

@immutable
@JsonSerializable()
class InteractiveLessonProgressResponse {
  final int id;
  final bool success;
  final String message;

  const InteractiveLessonProgressResponse(
    this.id,
    this.success,
    this.message,
  );

  static InteractiveLessonProgressResponse fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonProgressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InteractiveLessonProgressResponseToJson(this);
}
