import 'package:loopcare_frontend/features/assignments/infrastructure/answer_widget_type.dart';

enum LessonQuestionAnswerType {
  scale,
  multipleChoiceMultiple,
  multipleChoiceSingle,
  text,
  multipleChoiceValidation
}

extension LessonQuestionAnswerTypeX on LessonQuestionAnswerType {
  AnswerWidgetType get widgetType {
    switch (this) {
      case LessonQuestionAnswerType.scale:
        return const AnswerWidgetType.scale();
      case LessonQuestionAnswerType.multipleChoiceMultiple:
        return const AnswerWidgetType.multipleChoiceMultiple();
      case LessonQuestionAnswerType.multipleChoiceSingle:
        return const AnswerWidgetType.multipleChoiceSingle();
      case LessonQuestionAnswerType.text:
        return const AnswerWidgetType.text();
      case LessonQuestionAnswerType.multipleChoiceValidation:
        return const AnswerWidgetType.multipleChoiceValidation();
    }
  }
}
