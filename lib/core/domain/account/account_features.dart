import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';

part 'account_features.freezed.dart';
part 'account_features.g.dart';

@freezed
class AccountFeatures with _$AccountFeatures {
  const AccountFeatures._();

  const factory AccountFeatures({
    @Default(false) bool allowGroupSessions,
    @Default(false) bool reflections,
    @Default(false) bool foodLogging,
    @Default(false) bool calorieDensity,
    @Default(false) bool smartGoals,
    @Default(false) bool weightLogging,
    @Default(false) bool physicalActivity,
    @Default(false) bool buddy,
    @Default(false) bool grouping,
    @Default(false) bool proteinDegree,
    @Default(false) bool mind,
    @Default(false) bool fiberIndicator,
    @Default(false) bool calorieTracker,
  }) = _AccountFeatures;

  AccountFeatures unlockFeature(UnlockedFeatureType key) {
    final Map<String, AccountFeatures> featureUpdateMap = {
      'allowGroupSessions': copyWith(allowGroupSessions: true),
      'reflections': copyWith(reflections: true),
      'foodLogging': copyWith(foodLogging: true),
      'calorieDensity': copyWith(calorieDensity: true),
      'smartGoals': copyWith(smartGoals: true),
      'weightLogging': copyWith(weightLogging: true),
      'physicalActivity': copyWith(physicalActivity: true),
      'buddy': copyWith(buddy: true),
      'grouping': copyWith(grouping: true),
      'proteinDegree': copyWith(proteinDegree: true),
      'mind': copyWith(mind: true),
      'fiberIndicator': copyWith(fiberIndicator: true),
      'calorieTracker': copyWith(calorieTracker: true),
    };

    if (featureUpdateMap.containsKey(key.name)) {
      return featureUpdateMap[key.name]!;
    } else {
      throw ArgumentError('Invalid feature key: $key');
    }
  }

  factory AccountFeatures.fromJson(Map<String, dynamic> json) => _$AccountFeaturesFromJson(json);

  bool isFeatureUnlocked(UnlockedFeatureType feature) => switch (feature) {
        UnlockedFeatureType.allowGroupSessions => allowGroupSessions,
        UnlockedFeatureType.reflections => reflections,
        UnlockedFeatureType.foodLogging => foodLogging,
        UnlockedFeatureType.calorieDensity => calorieDensity,
        UnlockedFeatureType.smartGoals => smartGoals,
        UnlockedFeatureType.weightLogging => weightLogging,
        UnlockedFeatureType.physicalActivity => physicalActivity,
        UnlockedFeatureType.buddy => buddy,
        UnlockedFeatureType.grouping => grouping,
        UnlockedFeatureType.proteinDegree => proteinDegree,
        UnlockedFeatureType.mind => mind,
        UnlockedFeatureType.fiberIndicator => fiberIndicator,
        UnlockedFeatureType.calorieTracker => calorieTracker,
      };
}
