import 'package:freezed_annotation/freezed_annotation.dart';

part 'questions_page_mode.freezed.dart';

@freezed
class QuestionsPageMode with _$QuestionsPageMode {
  const factory QuestionsPageMode.askQuestion() = AskQuestion;

  const factory QuestionsPageMode.showAnswer() = ShowAnswer;
}
