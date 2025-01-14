part of 'subscription_v2_bloc.dart';

@freezed
class SubscriptionV2State with _$SubscriptionV2State {
  const factory SubscriptionV2State.initial(SubscriptionV2StateData data) =
      SubscriptionV2StateInitial;

  const factory SubscriptionV2State.loading(SubscriptionV2StateData data) =
      SubscriptionV2StateLoading;

  const factory SubscriptionV2State.error(SubscriptionV2StateData data) = SubscriptionV2StateError;

  const factory SubscriptionV2State.loaded(SubscriptionV2StateData data) =
      SubscriptionV2StateLoaded;

  const factory SubscriptionV2State.gotServerPlans(SubscriptionV2StateData data) = GotServerPlans;

  // const factory SubscriptionV2State.logout(SubscriptionV2StateData data) = LogoutState;
  //
  // const factory SubscriptionV2State.gotAccountSubscription(SubscriptionV2StateData data) = GotAccountSubscription;
  //
  // const factory SubscriptionV2State.setEligibility(SubscriptionV2StateData data) = SetEligibilitySubscription;
  //
  // const factory SubscriptionV2State.subscriptionUnRenewed(SubscriptionV2StateData data) = SubscriptionUnRenewed;
  //
  // const factory SubscriptionV2State.success(SubscriptionV2StateData data) = SuccessSubscriptionState;

  // const factory SubscriptionV2State.successInPlans(SubscriptionV2StateData data) = SuccessSubscriptionPlans;
  //
  // const factory SubscriptionV2State.processedDataPlans(SubscriptionV2StateData data) = processedDataPlans;
  //
  // const factory SubscriptionV2State.purchasedSubscription(SubscriptionV2StateData data) = PurchasedSubscriptionState;
  //
  // const factory SubscriptionV2State.restoredSubscription(SubscriptionV2StateData data) = RestoredSubscriptionState;
  //
  // const factory SubscriptionV2State.askRestoredSubscription(SubscriptionV2StateData data) = AskRestoredSubscriptionState;
  //
  // const factory SubscriptionV2State.subscriptionActive(SubscriptionV2StateData data) = SubscriptionActual;
  //
  // const factory SubscriptionV2State.serviceSubscriptionUnavailable(SubscriptionV2StateData data) = ServiceSubscriptionUnavailable;
  //
  // const factory SubscriptionV2State.purchaseDuplicateSubscription(SubscriptionV2StateData data) = PurchasedDuplicateSubscriptionV2State;
}

@freezed
class SubscriptionV2StateData with _$SubscriptionV2StateData {
  const SubscriptionV2StateData._();

  factory SubscriptionV2StateData({
    RequestError? error,
    @Default(false) bool isLoading,
    @Default(0) int id,
    @Default('') String type,
    @Default('') String title,
    @Default('') String label,
    @Default('') String subText,
    @Default([]) List<SubscriptionPlanV2> plans,
    // @Default(<ProductDetails>[]) List<ProductDetails> plans2,
    @Default(<ServerProduct>[]) List<ServerProduct> serverPlans,
    // @Default(<PurchaseDetails>[]) List<PurchaseDetails> purchases,
    // PurchasedProductV2? purchased,
    // PurchaseDetails? lastPurchase,
    // Subscription? subscription,
    // ProductDetails? product,
    // @Default(false) bool isEligible,
    @Default(0) int checkedId,
    @Default(false) bool onChecked,
    @Default([]) List<SubscriptionPlanContentV2> content,
  }) = _SubscriptionV2StateData;
}
