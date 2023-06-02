import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_content.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson_page_type.dart';

part 'lesson_page.freezed.dart';
part 'lesson_page.g.dart';

@freezed
abstract class LessonPage implements _$LessonPage {
  const LessonPage._();

  const factory LessonPage({
    required EducationLessonPageType type,
    required LessonContent content,
    required int order,
  }) = _LessonPage;

  factory LessonPage.empty() => const LessonPage(
        content: LessonContent(),
        order: 0,
        type: EducationLessonPageType.text,
      );

  factory LessonPage.fromJson(Map<String, dynamic> json) =>
      _$LessonPageFromJson(json);
}
