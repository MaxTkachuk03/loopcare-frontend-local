import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_content_type.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz.dart';

part 'get_lesson_content_response.g.dart';

@immutable
@JsonSerializable()
class GetLessonContentResponse {
  final int id;
  final String title;
  final int duration;
  final LessonContentType contentType;
  final String imageUrl;
  final String cardImageUrl;
  final String? audioUrl;
  final String htmlUrl;
  final String? subtitleImages;
  final Quiz? quiz;
  final String? conclusion;
  final String? unlockTitle;
  final String? unlockDescription;

  const GetLessonContentResponse(
    this.id,
    this.title,
    this.duration,
    this.contentType,
    this.imageUrl,
    this.cardImageUrl,
    this.audioUrl,
    this.htmlUrl,
    this.subtitleImages,
    this.quiz,
    this.conclusion,
    this.unlockTitle,
    this.unlockDescription,
  );

  static GetLessonContentResponse fromJson(Map<String, dynamic> json) =>
      _$GetLessonContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLessonContentResponseToJson(this);
}
