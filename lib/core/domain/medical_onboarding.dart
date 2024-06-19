import 'package:freezed_annotation/freezed_annotation.dart';

part 'medical_onboarding.freezed.dart';
part 'medical_onboarding.g.dart';

@freezed
abstract class MedicalOnboarding implements _$MedicalOnboarding {
  const MedicalOnboarding._();

  const factory MedicalOnboarding({
    @Default(false) bool pregnant,
    @Default([]) List<String> medicines,
    @Default('') String howLongTakeSemaglutideMedication,
    @Default('') String howLongSemaglutideTreatmentLast,
    @Default('') String useSemaglutideMedication,
    @Default('') String diabetes,
    @Default(false) bool isUseSemaglutideMedication,
    @Default(false) bool obesity,
    @Default(false) bool thyroidDesease,
    @Default(false) bool metabolicDesease,
    @Default(false) bool hypertension,
    @Default(false) bool cardiovascularDesease,
    @Default(false) bool stomachReduction,
    @Default(false) bool renalFailure,
    @Default(false) bool asthma,
    @Default(false) bool liverDesease,
    @Default(false) bool sleepApneaSyndrome,
    @Default(false) bool locomotorSystemDesease,
    @Default(false) bool treatedByPsychiatrist,
  }) = _MedicalOnboarding;

  factory MedicalOnboarding.fromJson(Map<String, dynamic> json) => _$MedicalOnboardingFromJson(json);
}
