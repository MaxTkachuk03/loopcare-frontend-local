import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/gender_preferences.dart';

part 'group_preferences_body.g.dart';

@JsonSerializable(includeIfNull: false)
class GroupPreferencesBody {
  final GenderPreferences? genderPreference;
  final String? timezone;
  final String? nickname;
  final bool? rulesAccepted;

  const GroupPreferencesBody({
    this.genderPreference,
    this.timezone,
    this.nickname,
    this.rulesAccepted,
  });

  factory GroupPreferencesBody.fromJson(Map<String, dynamic> json) => _$GroupPreferencesBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPreferencesBodyToJson(this);
}
