import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_answer.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_answer_type.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_feedback.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_option.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_type.dart';
import 'package:collection/collection.dart';

part 'lesson_question.freezed.dart';

part 'lesson_question.g.dart';

@freezed
class LessonQuestion with _$LessonQuestion {
  const LessonQuestion._();

  const factory LessonQuestion({
    required int id,
    required LessonQuestionAnswerType answerType,
    required LessonQuestionType type,
    required String title,
    required String visual,
    required String instruction,
    required String? introduction,
    required String? explanationCorrect,
    required String? explanationIncorrect,
    required String? lowestText,
    required String? highestText,
    required String? question,
    required List<LessonQuestionOption> lessonQuestionOptions,
    required List<LessonQuestionFeedback> lessonQuestionFeedbacks,
    required List<LessonQuestionAnswer> lessonQuestionAnswers,
    required DateTime? createdAt,
  }) = _LessonQuestion;

  int lessonQuestionOptionIndexById(int id) {
    var lessonQuestionOption = lessonQuestionOptions.firstWhere((element) => element.id == id);
    return lessonQuestionOptions.indexOf(lessonQuestionOption);
  }

  LessonQuestionOption lessonQuestionOptionById(int id) {
    return lessonQuestionOptions.firstWhere((element) => element.id == id);
  }

  LessonQuestionAnswer? get questionAnswer =>
      lessonQuestionAnswers.firstWhereOrNull((el) => el.lessonQuestionId == id);

  List<int> get lessonQuestionAnswersId {
    var retList = <int>[];

    for (var element in lessonQuestionAnswers) {
      var lessonQuestionOptionId = element.lessonQuestionOptionId;
      if (lessonQuestionOptionId != null) {
        retList.add(lessonQuestionOptionId);
      }
    }

    return retList;
  }

  List<String> get lessonQuestionOptionsLabels => lessonQuestionOptions.map((e) => e.label).toList();

  factory LessonQuestion.fromJson(Map<String, dynamic> json) => _$LessonQuestionFromJson(json);
}
