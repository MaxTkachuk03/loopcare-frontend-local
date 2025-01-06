import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_translation_v2.g.dart';

@immutable
@JsonSerializable()
class SubscriptionTranslationV2 {
  final String? customBillingPeriodText;
  final String? offerDescription;
  final String? badge;

  const SubscriptionTranslationV2({
    this.offerDescription,
    this.customBillingPeriodText,
    this.badge,
  });

  Map<String, dynamic> toJson() => _$SubscriptionTranslationV2ToJson(this);

  factory SubscriptionTranslationV2.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionTranslationV2FromJson(json);
}
