import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_widget_type.freezed.dart';

@freezed
class AnswerWidgetType with _$AnswerWidgetType {
  const factory AnswerWidgetType.scale() = AnswerWidgetTypeScale;

  const factory AnswerWidgetType.multipleChoiceMultiple() = AnswerWidgetTypeMultipleChoiceMultiple;

  const factory AnswerWidgetType.multipleChoiceSingle() = AnswerWidgetTypeMultipleChoiceSingle;

  const factory AnswerWidgetType.text() = AnswerWidgetTypeText;

  const factory AnswerWidgetType.multipleChoiceValidation() = AnswerWidgetTypeMultipleChoiceValidation;
}
