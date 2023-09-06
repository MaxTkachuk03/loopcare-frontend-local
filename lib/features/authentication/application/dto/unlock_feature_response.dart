import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';

part 'unlock_feature_response.g.dart';

@immutable
@JsonSerializable()
class UnlockFeatureResponse {
  final List<UnlockedFeatureType> unlockedFeatures;

  const UnlockFeatureResponse(this.unlockedFeatures);

  static UnlockFeatureResponse fromJson(Map<String, dynamic> json) =>
      _$UnlockFeatureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnlockFeatureResponseToJson(this);
}
