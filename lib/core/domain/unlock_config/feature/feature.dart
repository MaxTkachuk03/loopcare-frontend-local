import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';

part 'feature.freezed.dart';
part 'feature.g.dart';

@freezed
abstract class Feature implements _$Feature {
  const Feature._();

  const factory Feature({
    required UnlockedFeatureType feature,
    required bool unlocked,
    required List<UnlockedSubFeatureType>? subFeatures,
  }) = _Feature;

  factory Feature.fromJson(Map<String, dynamic> json) => _$FeatureFromJson(json);
}
