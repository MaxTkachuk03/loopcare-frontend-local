import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/education/application/dto/education_lesson.dart';

part 'get_lessons_response.g.dart';

@immutable
@JsonSerializable()
class GetLessonsResponse {
  final List<EducationLesson> lessons;

  const GetLessonsResponse(this.lessons);

  static GetLessonsResponse fromJson(Map<String, dynamic> json) =>
      _$GetLessonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLessonsResponseToJson(this);
}
