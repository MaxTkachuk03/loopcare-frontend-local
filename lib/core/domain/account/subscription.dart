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
    @Default(false) bool isActive,
    String? vendor,
    String? state,
    SubscriptionPlan? subscriptionPlan,
    // @Default(0) int id,
    // @Default('2023-10-13T10:28:20.536Z') String expiresAt,
    // @Default('2023-09-12T10:28:20.536Z') String purchasedAt,
    // @Default(false) bool isActive,
    // @Default('ios') String vendor,
    //  @Default('trialPeriod') String state,
    // @Default('common') String state,
    // @Default('cancelled') String state,
    // @Default('gracePeriod') String state,
    // @Default(SubscriptionPlan()) SubscriptionPlan subscriptionPlan,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
}
