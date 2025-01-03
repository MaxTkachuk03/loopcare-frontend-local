part of 'subscription_v2_bloc.dart';

@freezed
class SubscriptionV2Event with _$SubscriptionV2Event {
  const factory SubscriptionV2Event.getPlans() = GetPlans;

  const factory SubscriptionV2Event.onCheckedPlan(bool onChecked, int checkedId) = OnCheckedPlan;
}
