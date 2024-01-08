import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/mental_health_tests.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/sex_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account implements _$Account {
  const Account._();

  const factory Account({
    required int id,
    required String name,
    required String email,
    required String? country,
    required SexType gender,
    required String bioGender,
    @Default(null) UserGroupingState? groupingState,
    @Default(null) int? groupId,
    @Default(null) DateTime? groupingStartedAt,
    @Default(0) double height,
    @Default(0) double weight,
    @Default(0) double bmi,
    DateTime? birthDate,
    @Default('') String diabetes,
    @Default('') String? nickname,
    @Default(GenderPreferences.noPreference) GenderPreferences? genderPreference,
    @Default('') String? timezone,
    @Default([]) List<FoodPreference>? foodPreferencesHates,
    @Default([]) List<FoodPreference>? foodPreferencesDislikes,
    @Default([]) List<FoodPreference>? foodPreferencesAllergic,
    @Default([]) List<UnlockedFeatureType> unlockedFeatures,
    PhysicalActivitiesPreferences? physicalActivitiesPreferences,
    @Default(null) MentalHealthTests? mentalHealthTests,
    @Default(null) DateTime? emailApproveDate,
  }) = _Account;

  bool get isMixedGender => gender != SexType.female && gender != SexType.male;

  int get trainingFrequency {
    final RegExpMatch? match = RegExp(r'(\d+)').firstMatch(physicalActivitiesPreferences?.trainingFrequency ?? '');

    return match != null ? int.parse(match[0] ?? '0') : 0;
  }

  bool get disableGroupSessions {
    final bool disableGroupSessions = _oneTestHasHighValues || _allTestsAreModerate;

    return mentalHealthTests != null && disableGroupSessions ? true : false;
  }

  bool get _oneTestHasHighValues =>
      mentalHealthTests?.phq8 == InterpretationType.high.name ||
      mentalHealthTests?.phq15 == InterpretationType.high.name ||
      mentalHealthTests?.gad7 == InterpretationType.high.name;

  bool get _allTestsAreModerate =>
      mentalHealthTests?.phq8 == InterpretationType.moderate.name &&
      mentalHealthTests?.phq15 == InterpretationType.moderate.name &&
      mentalHealthTests?.gad7 == InterpretationType.moderate.name;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
