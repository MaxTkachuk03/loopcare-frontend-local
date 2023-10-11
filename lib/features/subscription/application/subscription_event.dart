part of 'subscription_bloc.dart';

@freezed
class SubscriptionEvent with _$SubscriptionEvent {
  const factory SubscriptionEvent.getStatusSubscription() = GetStatusSubscription;

  const factory SubscriptionEvent.buySubscription(ProductDetails product) = BuySubscription;

  const factory SubscriptionEvent.getSubscriptionPlans() = GetSubscriptionPlans;

  const factory SubscriptionEvent.init() = SubscriptionInit;

  const factory SubscriptionEvent.dispose() = SubscriptionDispose;

  const factory SubscriptionEvent.purchasedSubscription(PurchasedProduct purchasedProduct) = PurchasedSubscription;
}
