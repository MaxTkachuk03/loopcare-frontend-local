import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/image_content/image_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_type.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/markdown_content/markdown_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/meal_timing_content/meal_timing_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/ordering_content/ordering_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/scale_content/scale_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/select_content/select_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/text_field_content/text_field_content.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

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
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentMarkdown;

  const factory InteractiveLessonChunkComponent.image({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required ImageContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentImage;

  const factory InteractiveLessonChunkComponent.scale({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required ScaleContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentScale;

  const factory InteractiveLessonChunkComponent.singleSelect({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required SelectContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentSingleSelect;

  const factory InteractiveLessonChunkComponent.multipleSelect({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required SelectContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentMultipleSelect;

  const factory InteractiveLessonChunkComponent.singleSelectWithFeedback({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required SelectContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentSingleSelectWithFeedback;

  const factory InteractiveLessonChunkComponent.ordering({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required OrderingContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentOrdering;

  const factory InteractiveLessonChunkComponent.textArea(
      {required int id,
      required InteractiveLessonComponentType type,
      required bool needsValidation,
      required bool isValid,
      required TextFieldContent content,
      required int chunkId,
      required InteractiveLessonComponentProgress? progress,
      required int maxCharsLength,
      required int maxTextFieldsAmount,
      required int minTextFieldsAmount}) = InteractiveLessonChunkComponentTextArea;

  const factory InteractiveLessonChunkComponent.textField({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required TextFieldContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentTextField;

  const factory InteractiveLessonChunkComponent.survey({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required SelectContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentSurvey;

  const factory InteractiveLessonChunkComponent.mealTiming({
    required int id,
    required InteractiveLessonComponentType type,
    required bool needsValidation,
    required bool isValid,
    required MealTimingContent content,
    required int chunkId,
    required InteractiveLessonComponentProgress? progress,
  }) = InteractiveLessonChunkComponentMealTiming;

  factory InteractiveLessonChunkComponent.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonChunkComponentFromJson(json);

  factory InteractiveLessonChunkComponent.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing InteractiveLessonChunkComponent: $json');

      // Validate the type field
      if (!json.containsKey('type') || json['type'] == null) {
        throw Exception('Missing or invalid "type" in JSON: $json');
      }

      log.d("raw id ${json['id']}");
      log.d("raw type ${json['type']}");
      log.d("raw needsValidation ${json['needsValidation']}");
      log.d("raw isValid ${json['isValid']}");
      log.d("raw chunkId ${json['chunkId']}");
      log.d("raw progress ${json['progress']}");
      log.d("raw content ${json['content']}");
      log.d("raw imageURL ${json['imageURL']}");
      log.d('Content type: ${json['content'].runtimeType}');
      log.d('Nested content: ${(json['content'] as Map<String, dynamic>)['content']}');
      log.d(
          'Nested content type: ${(json['content'] as Map<String, dynamic>)['content'].runtimeType}');

      final type = json['type'] as String;

      // Parse common fields
      final id = json['id'] as int;
      final needsValidation = json['needsValidation'] as bool;
      final isValid = json['isValid'] as bool;
      final chunkId = json['chunkId'] as int;
      final progressList = (json['progress'] as List<dynamic>? ?? [])
          .map((e) => InteractiveLessonComponentProgress.debugFromJson(e as Map<String, dynamic>))
          .toList();
      final progress =
          progressList.isNotEmpty ? progressList[0] : null; // Handle type-specific parsing

      // Preprocess and normalize the nested content
      if (json['content'] is Map<String, dynamic>) {
        if (json['content']['content'] is String) {
          json['content']['content'] = jsonDecode(json['content']['content'] as String);
        }
      } else {
        throw FormatException('Invalid content structure: ${json['content']}');
      }

      // Log the normalized content
      log.d('Normalized content: ${json['content']}');
      final imageURL = json['content']['imageURL'];
      log.d('imageURL: $imageURL');

      switch (type) {
        case 'markdown':
          return InteractiveLessonChunkComponent.markdown(
            id: id,
            type: InteractiveLessonComponentType.markdown,
            needsValidation: needsValidation,
            isValid: isValid,
            content: MarkdownContent.fromJson(json['content']['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );

        case 'image':
          return InteractiveLessonChunkComponent.image(
            id: id,
            type: InteractiveLessonComponentType.image,
            needsValidation: needsValidation,
            isValid: isValid,
            // content: ImageContent.fromJson(json['content']['content'] as Map<String, dynamic>),
            content: ImageContent(src: imageURL),
            chunkId: chunkId,
            progress: progress,
          );

        case 'scale':
          return InteractiveLessonChunkComponent.scale(
            id: id,
            type: InteractiveLessonComponentType.scale,
            needsValidation: needsValidation,
            isValid: isValid,
            content: ScaleContent.debugFromJson(json['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );

        case 'singleSelect':
          return InteractiveLessonChunkComponent.singleSelect(
            id: id,
            type: InteractiveLessonComponentType.singleSelect,
            needsValidation: needsValidation,
            isValid: isValid,
            content: SelectContent.debugFromJson(json['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );

        case 'multipleSelect':
          return InteractiveLessonChunkComponent.multipleSelect(
            id: id,
            type: InteractiveLessonComponentType.multipleSelect,
            needsValidation: needsValidation,
            isValid: isValid,
            content: SelectContent.debugFromJson(json['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );

        case 'singleSelectWithFeedback':
          return InteractiveLessonChunkComponent.singleSelectWithFeedback(
            id: id,
            type: InteractiveLessonComponentType.singleSelectWithFeedback,
            needsValidation: needsValidation,
            isValid: isValid,
            content: SelectContent.debugFromJson(json['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );

        case 'ordering':
          return InteractiveLessonChunkComponent.ordering(
            id: id,
            type: InteractiveLessonComponentType.ordering,
            needsValidation: needsValidation,
            isValid: isValid,
            content: OrderingContent.debugFromJson(json['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );

        case 'textArea':
          return InteractiveLessonChunkComponent.textArea(
            id: id,
            type: InteractiveLessonComponentType.textArea,
            needsValidation: needsValidation,
            isValid: isValid,
            content: TextFieldContent.fromJson(json['content']['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
            maxCharsLength: json['maxCharsLength'] as int? ?? 500, // Default to 500 if null
            maxTextFieldsAmount: json['maxTextFieldsAmount'] as int? ?? 5, // Default to 5 if null
            minTextFieldsAmount: json['minTextFieldsAmount'] as int? ?? 1, // Default to 1 if null
          );

        case 'textField':
          return InteractiveLessonChunkComponent.textField(
            id: id,
            type: InteractiveLessonComponentType.textField,
            needsValidation: needsValidation,
            isValid: isValid,
            content: TextFieldContent.fromJson(json['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );

        case 'survey':
          return InteractiveLessonChunkComponent.survey(
            id: id,
            type: InteractiveLessonComponentType.survey,
            needsValidation: needsValidation,
            isValid: isValid,
            content:
                SelectContent.debugFromJson(json['content']['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );
        case 'mealTiming':
          return InteractiveLessonChunkComponent.mealTiming(
            id: id,
            type: InteractiveLessonComponentType.mealTiming,
            needsValidation: needsValidation,
            isValid: isValid,
            content: MealTimingContent.debugFromJson(json['content'] as Map<String, dynamic>),
            chunkId: chunkId,
            progress: progress,
          );

        default:
          throw Exception('Unsupported component type: $type in JSON: $json');
      }
    } catch (e, stackTrace) {
      log.w('Error in InteractiveLessonChunkComponent.fromJson: $e');
      log.w('Stack Trace: $stackTrace');
      log.w('Problematic JSON: $json');
      rethrow;
    }
  }
}
