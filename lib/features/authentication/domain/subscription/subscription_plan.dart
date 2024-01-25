import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan.freezed.dart';

part 'subscription_plan.g.dart';

@freezed
class SubscriptionPlan with _$SubscriptionPlan {
  const SubscriptionPlan._();

  const factory SubscriptionPlan({
    required int id,
    required String title,
    required String description,
  }) = _SubscriptionPlan;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanFromJson(json);
}
