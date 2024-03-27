import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/gender_preferences.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/domain/mental_health_tests.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/feature/feature.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';
import 'package:loopcare_frontend/features/subscription/donain/subscription_state.dart';
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
    Buddy? buddy,
    @Default(null) UserGroupingState? groupingState,
    @Default(null) int? groupId,
    @Default(null) DateTime? groupingStartedAt,
    @Default(0) double height,
    @Default(0) double weight,
    @Default(0) double bmi,
    DateTime? birthDate,
    @Default('') String diabetes,
    @Default('') String? nickname,
    @Default(null) String? buddyState,
    @Default(GenderPreferences.noPreference) GenderPreferences? genderPreference,
    @Default('') String? timezone,
    @Default([]) List<FoodPreference>? foodPreferencesHates,
    @Default([]) List<FoodPreference>? foodPreferencesDislikes,
    @Default([]) List<FoodPreference>? foodPreferencesAllergic,
    @Default([]) List<Feature> features,
    PhysicalActivitiesPreferences? physicalActivitiesPreferences,
    MedicalOnboarding? medicalOnboarding,
    @Default(null) MentalHealthTests? mentalHealthTests,
    @Default(null) DateTime? emailApproveDate,
  }) = _Account;

  bool get isMixedGender => gender == GenderType.other;

  int get trainingFrequency {
    final RegExpMatch? match = RegExp(r'(\d+)').firstMatch(physicalActivitiesPreferences?.trainingFrequency ?? '');

    return match != null ? int.parse(match[0] ?? '0') : 0;
  }

  bool get isPhysicalActivitiesUnlocked =>
      features.firstWhereOrNull((feature) => feature.feature == UnlockedFeatureType.physicalActivities)?.unlocked ??
      false;

  bool get isFoodLoggingUnlocked =>
      features.firstWhereOrNull((feature) => feature.feature == UnlockedFeatureType.meals)?.unlocked ?? false;

  bool get isGroupSessionsUnlocked =>
      features.firstWhereOrNull((feature) => feature.feature == UnlockedFeatureType.grouping)?.unlocked ?? false;

  bool get isAssignmentsUnlocked =>
      features
          .firstWhereOrNull(
            (feature) => feature.feature == UnlockedFeatureType.assignments,
          )
          ?.unlocked ??
      false;

  bool get isBuddyUnlocked =>
      features.firstWhereOrNull((feature) => feature.feature == UnlockedFeatureType.buddy)?.unlocked ?? false;

  bool get isSmartGoalsUnlocked =>
      features.firstWhereOrNull((feature) => feature.feature == UnlockedFeatureType.smartGoals)?.unlocked ?? false;

  bool get disableGroupSessions => mentalHealthTests != null && _isPhq8High ? true : false;

  bool get _isPhq8High => mentalHealthTests?.phq8 == InterpretationType.high.name;

  bool get isUserGrouped => groupingState == UserGroupingState.grouped;

  bool get hasActiveSubscription => subscription.isActive;

  bool get isOnTrial => subscription.isActive && subscription.state != SubscriptionStatus.trialPeriod;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
