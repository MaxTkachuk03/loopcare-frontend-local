import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_content.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_content_type.dart';

part 'lesson_page.freezed.dart';
part 'lesson_page.g.dart';

@freezed
abstract class LessonPage implements _$LessonPage {
  const LessonPage._();

  const factory LessonPage({
    required LessonContentType type,
    required LessonContent content,
    required int order,
  }) = _LessonPage;

  factory LessonPage.fromJson(Map<String, dynamic> json) => _$LessonPageFromJson(json);
}
