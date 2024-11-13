import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz_question.dart';

part 'quiz.freezed.dart';

part 'quiz.g.dart';

@freezed
class Quiz with _$Quiz {
  const Quiz._();

  const factory Quiz({
    required int id,
    required String instruction,
    required List<QuizQuestion> questions,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
