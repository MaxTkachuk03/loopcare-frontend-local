import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/subscription_plan.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

@freezed
abstract class Subscription implements _$Subscription {
  const Subscription._();

  const factory Subscription({
    int? id,
    String? expiresAt,
    String? purchasedAt,
    String? serverDate,
    double? price,
    @Default(false) bool isActive,
    String? vendor,
    String? state,
    SubscriptionPlan? subscriptionPlan,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
}
