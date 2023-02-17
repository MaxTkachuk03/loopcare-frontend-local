part of 'self_help_bloc.dart';

@freezed
class SelfHelpState with _$SelfHelpState {
  factory SelfHelpState.initial() => SelfHelpState(
        currentQuestion: SelfHelpQuestions.values[0],
      );

  const factory SelfHelpState({
    required SelfHelpQuestions currentQuestion,
    @Default(false) bool isCompletedSuccessfully,
    @Default(false) bool isCompletedWithError,
    PreferGenderType? preferGenderType,
  }) = _SelfHelpState;

  factory SelfHelpState.fromJson(Map<String, dynamic> json) =>
      _$SelfHelpStateFromJson(json);
}
