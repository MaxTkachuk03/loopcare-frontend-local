import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';

part 'calendar_lessons_response.g.dart';

@immutable
@JsonSerializable()
class CalendarLessonsResponse {
  final List<EducationLesson> lessons;
  final EducationLesson? nextLesson;

  const CalendarLessonsResponse(
    this.lessons,
    this.nextLesson,
  );

  static CalendarLessonsResponse fromJson(Map<String, dynamic> json) =>
      _$CalendarLessonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarLessonsResponseToJson(this);
}
