import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/lesson_unlock_config/lesson_unlock_config.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_page.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';

part 'get_lesson_content_response.g.dart';

@immutable
@JsonSerializable()
class GetLessonContentResponse {
  final int id;
  final String category;
  final String title;
  final String image;
  final int duration;
  final int pageCounter;
  final LessonUnlockConfig unlockingConfig;
  final DateTime? completedAt;
  final int step;
  final List<LessonPage> pages;
  final List<LessonQuestion> questions;

  const GetLessonContentResponse(
    this.id,
    this.category,
    this.title,
    this.image,
    this.duration,
    this.pageCounter,
    this.unlockingConfig,
    this.completedAt,
    this.step,
    this.pages,
    this.questions,
  );

  static GetLessonContentResponse fromJson(Map<String, dynamic> json) => _$GetLessonContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLessonContentResponseToJson(this);
}
