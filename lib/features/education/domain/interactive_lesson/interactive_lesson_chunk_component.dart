import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/image_content/image_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_type.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/markdown_content/markdown_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/ordering_content/ordering_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/scale_content/scale_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/select_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/text_field_content/text_field_content.dart';

part 'interactive_lesson_chunk_component.freezed.dart';
part 'interactive_lesson_chunk_component.g.dart';

@Freezed(unionKey: 'type')
class InteractiveLessonChunkComponent with _$InteractiveLessonChunkComponent {
  const InteractiveLessonChunkComponent._();

  const factory InteractiveLessonChunkComponent.markdown({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required MarkdownContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentMarkdown;

  const factory InteractiveLessonChunkComponent.image({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required ImageContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentImage;

  const factory InteractiveLessonChunkComponent.scale({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required ScaleContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentScale;

  const factory InteractiveLessonChunkComponent.singleSelect({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required SelectContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentSingleSelect;

  const factory InteractiveLessonChunkComponent.multipleSelect({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required SelectContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentMultipleSelect;

  const factory InteractiveLessonChunkComponent.singleSelectWithFeedback({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required SelectContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentSingleSelectWithFeedback;

  const factory InteractiveLessonChunkComponent.ordering({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required OrderingContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentOrdering;

  const factory InteractiveLessonChunkComponent.textArea({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required TextFieldContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentTextArea;

  const factory InteractiveLessonChunkComponent.textField({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required TextFieldContent content,
    required int chunkId,
  }) = InteractiveLessonChunkComponentTextField;

  factory InteractiveLessonChunkComponent.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonChunkComponentFromJson(json);
}
