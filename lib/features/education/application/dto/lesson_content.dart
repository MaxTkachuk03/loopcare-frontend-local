import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_content.freezed.dart';
part 'lesson_content.g.dart';

@freezed
abstract class LessonContent implements _$LessonContent {
  const LessonContent._();

  const factory LessonContent({
    @Default('') String url,
    @Default('') String html,
    @Default(null) String? subtitlesText,
    @Default(null) String? subtitlesImages,
    @Default(null) String? backgroundAnimation,
    @Default('') String audioFilePath,
    @Default('') String subtitleFilePath,
  }) = _LessonContent;

  factory LessonContent.fromJson(Map<String, dynamic> json) =>
      _$LessonContentFromJson(json);
}
