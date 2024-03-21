part of 'physical_questions_bloc.dart';

@freezed
class PhysicalQuestionsEvent with _$PhysicalQuestionsEvent {
  const factory PhysicalQuestionsEvent.resetData() = ResetData;

  const factory PhysicalQuestionsEvent.heightChanged({
    required String height,
    required MeasurementSystemType measurementSystemType,
  }) = HeightChanged;

  const factory PhysicalQuestionsEvent.weightChanged({
    required String weight,
    required MeasurementSystemType measurementSystemType,
  }) = WeightChanged;

  const factory PhysicalQuestionsEvent.birthdayChanged(
    DateTime birthday,
  ) = BirthdayChanged;

  const factory PhysicalQuestionsEvent.sexChanged(
    SexType sexType,
  ) = SexChanged;

  const factory PhysicalQuestionsEvent.genderChanged(
    GenderType gender,
  ) = GenderChanged;

  const factory PhysicalQuestionsEvent.happinessChanged(
    int happiness,
  ) = HappinessChanged;

  const factory PhysicalQuestionsEvent.savePhysicalData() = SavePhysicalData;
}
