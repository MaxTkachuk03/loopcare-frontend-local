part of 'manage_subscription_bloc.dart';

@freezed
class ManageSubscriptionEvent with _$ManageSubscriptionEvent {
  const factory ManageSubscriptionEvent.init() = ManageSubscriptionInit;

  const factory ManageSubscriptionEvent.cancelActiveSubscription() = CancelActiveSubscription;

  const factory ManageSubscriptionEvent.getActiveSubscriptionPlan(PurchaseDetails purchaseDetails) = GetActiveSubscriptionPlan;
}
