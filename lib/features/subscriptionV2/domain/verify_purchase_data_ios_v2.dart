import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_purchase_data_ios_v2.g.dart';

@immutable
@JsonSerializable()
class VerifyIOSPurchaseDataV2 {
  final String receipt;
  final String transactionId;

  const VerifyIOSPurchaseDataV2({
    required this.receipt,
    required this.transactionId,
  });

  factory VerifyIOSPurchaseDataV2.fromJson(Map<String, dynamic> json) =>
      _$VerifyIOSPurchaseDataV2FromJson(json);

  Map<String, dynamic> toJson() => _$VerifyIOSPurchaseDataV2ToJson(this);
}
