import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/account_features.dart';

part 'unlock_feature_response.g.dart';

@immutable
@JsonSerializable()
class UnlockFeatureResponse {
  final AccountFeatures features;
  const UnlockFeatureResponse(this.features);

  static UnlockFeatureResponse fromJson(Map<String, dynamic> json) =>
      _$UnlockFeatureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnlockFeatureResponseToJson(this);
}
