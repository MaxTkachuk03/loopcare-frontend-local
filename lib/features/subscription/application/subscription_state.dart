part of 'subscription_bloc.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial(SubscriptionStateData data) = InitialSubscriptionState;

  const factory SubscriptionState.loading(SubscriptionStateData data) = LoadingSubscriptionState;

  const factory SubscriptionState.error(SubscriptionStateData data) = ErrorSubscriptionState;

  const factory SubscriptionState.purchaseDuplicateSubscription(SubscriptionStateData data) =
      PurchasedDuplicateSubscriptionState;

  const factory SubscriptionState.singlePlan(SubscriptionStateData data) = SinglePlan;

  const factory SubscriptionState.multiplePlans(SubscriptionStateData data) = MultiplePlans;

  const factory SubscriptionState.subscriptionUnRenewed(SubscriptionStateData data) =
      SubscriptionUnRenewed;

  const factory SubscriptionState.success(SubscriptionStateData data) = SuccessSubscriptionState;

  const factory SubscriptionState.successInPlans(SubscriptionStateData data) =
      SuccessSubscriptionPlans;

  const factory SubscriptionState.processedDataPlans(SubscriptionStateData data) =
      processedDataPlans;

  const factory SubscriptionState.purchasedSubscription(SubscriptionStateData data) =
      PurchasedSubscriptionState;

  const factory SubscriptionState.restoredSubscription(SubscriptionStateData data) =
      RestoredSubscriptionState;

  const factory SubscriptionState.askRestoredSubscription(SubscriptionStateData data) =
      AskRestoredSubscriptionState;

  const factory SubscriptionState.subscriptionActive(SubscriptionStateData data) =
      SubscriptionActual;

  const factory SubscriptionState.serviceSubscriptionUnavailable(SubscriptionStateData data) =
      ServiceSubscriptionUnavailable;

  const factory SubscriptionState.gotPlansFromServer(SubscriptionStateData data) =
      GotPlansFromServer;

  const factory SubscriptionState.logout(SubscriptionStateData data) = LogoutState;

  const factory SubscriptionState.gotAccountSubscription(SubscriptionStateData data) =
      GotAccountSubscription;

  const factory SubscriptionState.setEligibility(SubscriptionStateData data) =
      SetEligibilitySubscription;
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
    ProductDetails? product,
    @Default(false) bool isEligible,
  }) = _SubscriptionStateData;

  String get errorKey => error?.message ?? LocalizedTexts.errorSomethingWentWrong;

  bool get hasSubscription =>
      (subscription?.isActive ?? false) && subscription?.state != SubscriptionStatus.cancelled;
}
