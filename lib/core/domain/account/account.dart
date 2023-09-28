import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';
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
    required bool isPreferencesComplete,
    required SexType gender,
    required String bioGender,
    @Default(null) UserGroupingState? groupingState,
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
  }) = _Account;

  int get trainingFrequency {
    final RegExpMatch? match =
        RegExp(r'(\d+)').firstMatch(physicalActivitiesPreferences?.trainingFrequency ?? '');

    return match != null ? int.parse(match[0] ?? '0') : 0;
  }

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
