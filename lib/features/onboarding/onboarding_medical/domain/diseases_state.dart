import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/domain/diseases.dart';

part 'diseases_state.g.dart';

@JsonSerializable()
class DiseasesState {
  final Diseases diseases;
  final bool enable;

  const DiseasesState({required this.diseases, required this.enable});

  static DiseasesState fromJson(Map<String, dynamic> json) => _$DiseasesStateFromJson(json);

  Map<String, dynamic> toJson() => _$DiseasesStateToJson(this);
}
