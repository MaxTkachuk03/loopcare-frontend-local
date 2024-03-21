import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/domain/mental_health_tests.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/core/domain/account/gender_preferences.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/interpretation_type.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';

import 'gender_type.dart';

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
    required GenderType gender,
    required SexType sex,
    required Subscription subscription,
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
    MedicalOnboarding? medicalOnboarding,
    @Default(null) MentalHealthTests? mentalHealthTests,
    @Default(null) DateTime? emailApproveDate,
  }) = _Account;

  bool get isMixedGender => gender == GenderType.other;

  int get trainingFrequency {
    final RegExpMatch? match =
        RegExp(r'(\d+)').firstMatch(physicalActivitiesPreferences?.trainingFrequency ?? '');

    return match != null ? int.parse(match[0] ?? '0') : 0;
  }

  bool get disableGroupSessions => mentalHealthTests != null && _isPhq8High ? true : false;

  bool get _isPhq8High => mentalHealthTests?.phq8 == InterpretationType.high.name;

  bool get isUserGrouped => groupingState == UserGroupingState.grouped;

  bool get isPhysicalActivitiesUnlocked => unlockedFeatures.contains(UnlockedFeatureType.physicalActivities);

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
