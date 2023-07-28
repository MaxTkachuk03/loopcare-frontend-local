import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';

part 'group_preferences_body.g.dart';

@JsonSerializable(includeIfNull: false)
class GroupPreferencesBody {
  final GenderPreferences? genderPreference;
  final String? timezone;
  final String? nickname;

  const GroupPreferencesBody({
    this.genderPreference,
    this.timezone,
    this.nickname,
  });

  factory GroupPreferencesBody.fromJson(Map<String, dynamic> json) => _$GroupPreferencesBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPreferencesBodyToJson(this);
}
