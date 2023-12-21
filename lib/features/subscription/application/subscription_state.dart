part of 'subscription_bloc.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial(SubscriptionStateData data) = InitialSubscriptionState;

  const factory SubscriptionState.loading(SubscriptionStateData data) = LoadingSubscriptionState;

  const factory SubscriptionState.error(SubscriptionStateData data) = ErrorSubscriptionState;

  const factory SubscriptionState.trial(SubscriptionStateData data) = Trial;

  const factory SubscriptionState.trialExpired(SubscriptionStateData data) = TtrialExpired;

  const factory SubscriptionState.subscriptionEnded(SubscriptionStateData data) = SubscriptionEnded;

  const factory SubscriptionState.subscriptionCancelled(SubscriptionStateData data) = SubscriptionCancelled;

  const factory SubscriptionState.subscriptionUnRenewed(SubscriptionStateData data) = SubscriptionUnRenewed;

  const factory SubscriptionState.success(SubscriptionStateData data) = SuccessSubscriptionState;

  const factory SubscriptionState.successInPlans(SubscriptionStateData data) = SuccessSubscriptionPlans;

  const factory SubscriptionState.purchasedSubscription(SubscriptionStateData data) = PurchasedSubscriptionState;

  const factory SubscriptionState.restoredSubscription(SubscriptionStateData data) = RestoredSubscriptionState;

  const factory SubscriptionState.subscriptionActive(SubscriptionStateData data) = SubscriptionActual;

  const factory SubscriptionState.serviceSubscriptionUnavailable(SubscriptionStateData data) =
      ServiceSubscriptionUnavailable;

  const factory SubscriptionState.gotPlansFromServer(SubscriptionStateData data) = GotPlansFromServer;

  const factory SubscriptionState.logout(SubscriptionStateData data) = LogoutState;
}

@freezed
class SubscriptionStateData with _$SubscriptionStateData {
  const SubscriptionStateData._();

  const factory SubscriptionStateData({
    RequestError? error,
    @Default(false) bool isLoading,
    @Default(<ProductDetails>[]) List<ProductDetails> plans,
    @Default(<ServerProduct>[]) List<ServerProduct> serverPlans,
    @Default(<PurchaseDetails>[]) List<PurchaseDetails> purchases,
    PurchasedProduct? purchased,
    Subscription? subscription,
  }) = _SubscriptionStateData;

  String? get errorMessage => error?.maybeMap(conflict: (s) => s.error.error, orElse: () => null);
}
