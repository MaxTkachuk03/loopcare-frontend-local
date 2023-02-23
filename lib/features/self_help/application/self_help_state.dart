part of 'self_help_bloc.dart';

@freezed
class SelfHelpState with _$SelfHelpState {
  factory SelfHelpState.initial() => SelfHelpState(
        preferedGenderTypes: <PreferGender>[].toIList(),
        selectedType: null,
      );

  const factory SelfHelpState({
    @Default(false) bool isCompleted,
    PreferGender? selectedType,
    required IList<PreferGender> preferedGenderTypes,
  }) = _SelfHelpState;

  factory SelfHelpState.fromJson(Map<String, dynamic> json) =>
      _$SelfHelpStateFromJson(json);
}
