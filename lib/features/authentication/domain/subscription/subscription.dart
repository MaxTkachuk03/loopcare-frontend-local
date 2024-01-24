import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription_plan.dart';

part 'subscription.freezed.dart';

part 'subscription.g.dart';

@freezed
class Subscription with _$Subscription {
  const Subscription._();

  // TODO update field types when back end will be ready

  const factory Subscription({
    required DateTime serverDate,
    @Default(false) bool isActive,
    DateTime? expiresAt,
    DateTime? purchasedAt,
    double? price,
    String? state,
    String? vendor,
    SubscriptionPlan? subscriptionPlan,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
}
