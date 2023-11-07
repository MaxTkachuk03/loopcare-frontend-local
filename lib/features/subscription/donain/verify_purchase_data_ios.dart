import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_purchase_data_ios.g.dart';

@immutable
@JsonSerializable()
class VerifyIOSPurchaseData {
  final String receipt;
  final String transactionId;

  const VerifyIOSPurchaseData({
    required this.receipt,
    required this.transactionId,
  });

  factory VerifyIOSPurchaseData.fromJson(Map<String, dynamic> json) => _$VerifyIOSPurchaseDataFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyIOSPurchaseDataToJson(this);
}
