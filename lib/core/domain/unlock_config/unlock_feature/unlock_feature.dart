import 'package:freezed_annotation/freezed_annotation.dart';

part 'unlock_feature.freezed.dart';
part 'unlock_feature.g.dart';

@freezed
abstract class UnlockFeature implements _$UnlockFeature {
  const UnlockFeature._();

  const factory UnlockFeature({
    required String feature,
    required bool unlocked,
    required List<String>? subFeatures,
  }) = _UnlockFeature;

  factory UnlockFeature.fromJson(Map<String, dynamic> json) => _$UnlockFeatureFromJson(json);
}
