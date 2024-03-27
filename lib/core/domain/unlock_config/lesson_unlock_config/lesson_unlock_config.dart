import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/feature/feature.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';

part 'lesson_unlock_config.g.dart';

@immutable
@JsonSerializable()
class LessonUnlockConfig {
  final List<Feature> requiredFeatures;
  final List<Feature> unlockedFeatures;
  final int nextStepUnlockDelay;
  final ExtraActionTypes? extraAction;

  const LessonUnlockConfig(
    this.extraAction,
    this.requiredFeatures,
    this.unlockedFeatures,
    this.nextStepUnlockDelay,
  );

  static LessonUnlockConfig fromJson(Map<String, dynamic> json) => _$LessonUnlockConfigFromJson(json);

  Map<String, dynamic> toJson() => _$LessonUnlockConfigToJson(this);
}
