import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/lesson_quiz/domain/question_answer_type.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_feedback.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question_answer.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection_question_option.dart';

part 'reflection_question.freezed.dart';

part 'reflection_question.g.dart';

@freezed
class ReflectionQuestion with _$ReflectionQuestion {
  const ReflectionQuestion._();

  const factory ReflectionQuestion({
    required int id,
    required List<ReflectionFeedback> feedbacks,
    required String? question,
    required String? introduction,
    required QuestionAnswerType answerType,
    required String? lowestText,
    required String? highestText,
    required String? extraInstruction,
    required List<ReflectionQuestionAnswer> answers,
    required List<ReflectionQuestionOption> options,
  }) = _ReflectionQuestion;

  bool get hasAnswer => answers.isNotEmpty;

  factory ReflectionQuestion.fromJson(Map<String, dynamic> json) =>
      _$ReflectionQuestionFromJson(json);
}
