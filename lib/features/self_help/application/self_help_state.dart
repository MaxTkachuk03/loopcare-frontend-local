part of 'self_help_bloc.dart';

@freezed
class SelfHelpState with _$SelfHelpState {
  factory SelfHelpState.initial() => SelfHelpState(
        currentQuestion: SelfHelpQuestions.values[0],
        preferedGenderTypes: <PreferGender>[].toIList(),
        selectedType: null,
      );

  const factory SelfHelpState({
    required SelfHelpQuestions currentQuestion,
    @Default(false) bool isCompleted,
    PreferGender? selectedType,
    required IList<PreferGender> diabetesTypes,
  }) = _SelfHelpState;

  factory SelfHelpState.fromJson(Map<String, dynamic> json) =>
      _$SelfHelpStateFromJson(json);
}
