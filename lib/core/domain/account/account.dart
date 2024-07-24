import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/account_features.dart';
import 'package:loopcare_frontend/core/domain/account/gender_preferences.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/domain/constants.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/domain/mental_health_tests.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy.dart';
import 'package:loopcare_frontend/features/onboarding/domain/interpretation_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';
import 'package:loopcare_frontend/features/subscription/donain/subscription_state.dart';
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
    required String? customerIoId,
    required String? country,
    required GenderType gender,
    required SexType sex,
    required Subscription subscription,
    required AccountFeatures features,
    Buddy? buddy,
    @Default(null) UserGroupingState? groupingState,
    @Default(null) int? groupId,
    @Default(null) DateTime? groupingStartedAt,
    @Default(0) double height,
    @Default(0) double bmi,
    @Default(1) int termsAndConditionsVersion,
    @Default(1) int privacyPolicyVersion,
    DateTime? birthDate,
    @Default('') String diabetes,
    @Default('') String? nickname,
    @Default(null) String? buddyState,
    @Default(null) String? avatarUrl,
    @Default(GenderPreferences.noPreference) GenderPreferences? genderPreference,
    @Default('') String? timezone,
    @Default([]) List<FoodPreference>? foodPreferencesHates,
    @Default([]) List<FoodPreference>? foodPreferencesDislikes,
    @Default([]) List<FoodPreference>? foodPreferencesAllergic,
    PhysicalActivitiesPreferences? physicalActivitiesPreferences,
    MedicalOnboarding? medicalOnboarding,
    @Default(null) MentalHealthTests? mentalHealthTests,
    @Default(null) DateTime? emailApproveDate,
    DateTime? createdAt,
  }) = _Account;

  bool get isMixedGender => gender == GenderType.other;

  int get trainingFrequency {
    final RegExpMatch? match =
        RegExp(r'(\d+)').firstMatch(physicalActivitiesPreferences?.trainingFrequency ?? '');

    return match != null ? int.parse(match[0] ?? '0') : 0;
  }

  bool get isPhysicalActivitiesUnlocked => features.physicalActivity;

  bool get isFoodLoggingUnlocked => features.foodLogging;

  bool get isGroupSessionsUnlocked => features.grouping;

  bool get isReflectionsUnlocked => features.reflections;

  bool get isBuddyUnlocked => features.buddy;

  bool get isSmartGoalsUnlocked => features.smartGoals;

  bool get isMindUnlocked => features.mind;

  bool get isCalorieDensityUnlocked => features.calorieDensity;

  bool get isProteinDegreeUnlocked => features.proteinDegree;

  bool get isCalorieTrackerUnlocked => features.calorieTracker;

  bool get isCarbohydrateRatioUnlocked => features.fiberIndicator;

  bool get isWeightLoggingUnlocked => features.weightLogging;

  bool get disableGroupSessions => mentalHealthTests != null && _isPhq8High ? true : false;

  bool get _isPhq8High => mentalHealthTests?.phq8 == InterpretationType.high.name;

  bool get isUserGrouped => groupingState == UserGroupingState.grouped;

  bool get hasActiveSubscription => subscription.isActive;

  bool get isOnTrial => subscription.state == SubscriptionStatus.trialPeriod;

  String get nameCapitalised => name.isNotEmpty ? name.capitalizeEachWordFirstLetter() : '';

  int get fiberDailyGoal =>
      sex == SexType.male ? Constants.maleFiberDailyGoal : Constants.femaleFiberDailyGoal;

  int get minCalorieRangeValue => sex == SexType.male
      ? Constants.maleMinCaloriesRangeValue
      : Constants.femaleMinCaloriesRangeValue;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
