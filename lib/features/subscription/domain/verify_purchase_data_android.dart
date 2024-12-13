import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_purchase_data_android.g.dart';

@immutable
@JsonSerializable()
class VerifyAndroidPurchaseData {
  final String receipt;
  final String purchaseToken;

  const VerifyAndroidPurchaseData({
    required this.receipt,
    required this.purchaseToken,
  });

  factory VerifyAndroidPurchaseData.fromJson(Map<String, dynamic> json) =>
      _$VerifyAndroidPurchaseDataFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAndroidPurchaseDataToJson(this);
}
