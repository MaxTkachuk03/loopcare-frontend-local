import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/gender_preferences.dart';

part 'grouping_preferences.freezed.dart';

part 'grouping_preferences.g.dart';

@freezed
abstract class GroupingPreferences implements _$GroupingPreferences {
  const GroupingPreferences._();

  const factory GroupingPreferences({
    required String? nickname,
    required GenderPreferences? genderPreference,
    required String? timezone,
  }) = _GroupingPreferences;

  factory GroupingPreferences.fromJson(Map<String, dynamic> json) => _$GroupingPreferencesFromJson(json);
}
