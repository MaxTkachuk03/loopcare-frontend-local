part of 'diabetes_bloc.dart';

@freezed
class DiabetesState with _$DiabetesState {
  factory DiabetesState.initial() => DiabetesState(
        diabetesTypes: <DiabetesType>[].toIList(),
        selectedType: null,
      );

  const factory DiabetesState({
    @Default(false) bool isCompleted,
    DiabetesType? selectedType,
    required IList<DiabetesType> diabetesTypes,
  }) = _DiabetesState;

  const DiabetesState._();
}
