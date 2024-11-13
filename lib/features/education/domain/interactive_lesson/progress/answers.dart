import 'package:freezed_annotation/freezed_annotation.dart';

part 'answers.freezed.dart';
part 'answers.g.dart';

@freezed
class Answers with _$Answers {
  const factory Answers({
    List<int>? option,
    List<int>? order,
    String? response,
  }) = _Answers;

  factory Answers.fromJson(Map<String, dynamic> json) => _$AnswersFromJson(json);
}
