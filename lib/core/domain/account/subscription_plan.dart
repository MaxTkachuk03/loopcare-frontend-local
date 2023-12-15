import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan.freezed.dart';
part 'subscription_plan.g.dart';

@freezed
abstract class SubscriptionPlan implements _$SubscriptionPlan {
  const SubscriptionPlan._();

  const factory SubscriptionPlan({
    @Default(0) int id,
    @Default('Monthly') String title,
    @Default('Monthly subscription') String description,
    // @Default(1) double price,
  }) = _SubscriptionPlan;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanFromJson(json);
}
