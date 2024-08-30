import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_translation.g.dart';

@immutable
@JsonSerializable()
class SubscriptionTranslation {
  final String? customBillingPeriodText;
  final String? offerDescription;
  final String? badge;


  const SubscriptionTranslation({
    this.offerDescription,
    this.customBillingPeriodText,
    this.badge,
  });

  Map<String, dynamic> toJson() => _$SubscriptionTranslationToJson(this);

  factory SubscriptionTranslation.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionTranslationFromJson(json);
}
