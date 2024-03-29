import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/lesson_unlock_config/lesson_unlock_config.dart';

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
    required String cardImage,
    required int duration,
    required int pageCounter,
    required int step,
    required int order,
    required bool isLocked,
    required DateTime? completedAt,
    required LessonUnlockConfig unlockingConfig,
  }) = _EducationLesson;

  bool get isCompleted => completedAt != null;

  factory EducationLesson.fromJson(Map<String, dynamic> json) => _$EducationLessonFromJson(json);
}
