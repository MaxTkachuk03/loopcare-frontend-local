import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';

part 'lesson_with_countdown.freezed.dart';

part 'lesson_with_countdown.g.dart';

@freezed
abstract class LessonWithCountdown implements _$LessonWithCountdown {
  const LessonWithCountdown._();

  const factory LessonWithCountdown({
    required int timeRemaining,
    required EducationLesson lesson,
  }) = _LessonWithCountdown;

  factory LessonWithCountdown.fromJson(Map<String, dynamic> json) => _$LessonWithCountdownFromJson(json);
}
