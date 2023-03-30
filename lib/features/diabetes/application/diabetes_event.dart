part of 'diabetes_bloc.dart';

@freezed
class DiabetesEvent with _$DiabetesEvent {
  const factory DiabetesEvent.setDiabetesType(DiabetesType selectedType) =
      SetDiabetesType;

  const factory DiabetesEvent.fetchDiabetesTypes() = FetchDiabetesTypes;

  const factory DiabetesEvent.saveDiabetesType() = SaveDiabetesType;

  const factory DiabetesEvent.getAccountDiabetesType() = GetAccountDiabetesType;
}
