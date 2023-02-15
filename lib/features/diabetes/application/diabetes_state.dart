part of 'diabetes_bloc.dart';

@freezed
class DiabetesState with _$DiabetesState {
  factory DiabetesState.initial() => DiabetesState(
        diabetesTypes: <DiabetesType>[].toIList(),
      );

  const factory DiabetesState({
    @Default(false) bool isCompleted,
    required IList<DiabetesType> diabetesTypes,
  }) = _DiabetesState;

  const DiabetesState._();
}
