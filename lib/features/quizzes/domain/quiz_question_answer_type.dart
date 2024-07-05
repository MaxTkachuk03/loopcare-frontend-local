import 'package:loopcare_frontend/features/assignments/infrastructure/answer_widget_type.dart';

enum QuizQuestionAnswerType {
  scale,
  multipleChoiceMultiple,
  multipleChoiceSingle,
  text,
  multipleChoiceValidation
}

extension LessonQuestionAnswerTypeX on QuizQuestionAnswerType {
  AnswerWidgetType get widgetType {
    switch (this) {
      case QuizQuestionAnswerType.scale:
        return const AnswerWidgetType.scale();
      case QuizQuestionAnswerType.multipleChoiceMultiple:
        return const AnswerWidgetType.multipleChoiceMultiple();
      case QuizQuestionAnswerType.multipleChoiceSingle:
        return const AnswerWidgetType.multipleChoiceSingle();
      case QuizQuestionAnswerType.text:
        return const AnswerWidgetType.text();
      case QuizQuestionAnswerType.multipleChoiceValidation:
        return const AnswerWidgetType.multipleChoiceValidation();
    }
  }
}
