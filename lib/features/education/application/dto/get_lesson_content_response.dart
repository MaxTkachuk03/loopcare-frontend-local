import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_page.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';

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
  final ExtraActionTypes? extraAction;
  final DateTime? completedAt;
  final int step;
  final List<LessonPage> pages;

  const GetLessonContentResponse(
    this.pages,
    this.id,
    this.category,
    this.title,
    this.image,
    this.duration,
    this.extraAction,
    this.pageCounter,
    this.completedAt,
    this.step,
  );

  static GetLessonContentResponse fromJson(Map<String, dynamic> json) =>
      _$GetLessonContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLessonContentResponseToJson(this);
}
