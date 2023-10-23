import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_purchase_data.g.dart';

@immutable
@JsonSerializable()
class VerifyPurchaseData {
  final String purchaseToken;

  const VerifyPurchaseData({
    required this.purchaseToken,
  });

  factory VerifyPurchaseData.fromJson(Map<String, dynamic> json) => _$VerifyPurchaseDataFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPurchaseDataToJson(this);
}
