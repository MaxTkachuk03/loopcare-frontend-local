import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz_question_answer.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz_question_answer_type.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/quiz_question_option.dart';

part 'quiz_question.freezed.dart';

part 'quiz_question.g.dart';

@freezed
class QuizQuestion with _$QuizQuestion {
  const QuizQuestion._();

  const factory QuizQuestion({
    required int id,
    required String? explanationCorrect,
    required String? explanationIncorrect,
    required List<QuizQuestionOption> options,
    required List<QuizQuestionAnswer> answers,
    required String? question,
    required QuizQuestionAnswerType answerType,
  }) = _QuizQuestion;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => _$QuizQuestionFromJson(json);
}
