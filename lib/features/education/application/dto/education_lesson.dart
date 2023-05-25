import 'package:freezed_annotation/freezed_annotation.dart';

part 'education_lesson.freezed.dart';

part 'education_lesson.g.dart';

@freezed
abstract class EducationLesson implements _$EducationLesson {
  const EducationLesson._();

  const factory EducationLesson({
    required int id,
    required String category,
    required String title,
    required String image,
    required int duration,
    required int pageCounter,
    required int step,
    required int order,
    required DateTime? completedAt,
  }) = _EducationLesson;

  bool get isCompleted {
    return completedAt != null;
  }

  factory EducationLesson.fromJson(Map<String, dynamic> json) =>
      _$EducationLessonFromJson(json);
}
