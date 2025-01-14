import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_purchase_data_android_v2.g.dart';

@immutable
@JsonSerializable()
class VerifyAndroidPurchaseDataV2 {
  final String receipt;
  final String purchaseToken;

  const VerifyAndroidPurchaseDataV2({
    required this.receipt,
    required this.purchaseToken,
  });

  factory VerifyAndroidPurchaseDataV2.fromJson(Map<String, dynamic> json) =>
      _$VerifyAndroidPurchaseDataV2FromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAndroidPurchaseDataV2ToJson(this);
}
