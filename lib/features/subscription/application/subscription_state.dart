part of 'subscription_bloc.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial(SubscriptionStateData data) = InitialSubscriptionState;

  const factory SubscriptionState.success(SubscriptionStateData data) = SuccessSubscriptionState;

  const factory SubscriptionState.successInPlans(SubscriptionStateData data) = SuccessSubscriptionPlans;

  const factory SubscriptionState.purchasedSubscription(SubscriptionStateData data) = PurchasedSubscriptionState;

  const factory SubscriptionState.loading(SubscriptionStateData data) = LoadingSubscriptionState;

  const factory SubscriptionState.error(SubscriptionStateData data) = ErrorSubscriptionState;

  const factory SubscriptionState.trial(SubscriptionStateData data) = Trial;

  const factory SubscriptionState.trialExpired(SubscriptionStateData data) = TtrialExpired;

  const factory SubscriptionState.subscriptionEnded(SubscriptionStateData data) = SubscriptionEnded;

  const factory SubscriptionState.subscriptionCancelled(SubscriptionStateData data) = SubscriptionCancelled;

  const factory SubscriptionState.subscriptionUnRenewed(SubscriptionStateData data) = SubscriptionUnRenewed;
}

@freezed
class SubscriptionStateData with _$SubscriptionStateData {
  const SubscriptionStateData._();

  const factory SubscriptionStateData({
    RequestError? error,
    @Default(false) bool isLoading,
    @Default(<ProductDetails>[]) List<ProductDetails> plans,
    @Default(<PurchaseDetails>[]) List<PurchaseDetails> purchases,
    PurchasedProduct? purchased,
  }) = _SubscriptionStateData;
}
