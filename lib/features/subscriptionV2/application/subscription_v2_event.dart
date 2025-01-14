part of 'subscription_v2_bloc.dart';

@freezed
class SubscriptionV2Event with _$SubscriptionV2Event {
  const factory SubscriptionV2Event.getPlans() = GetPlans;

  const factory SubscriptionV2Event.onCheckedPlan(bool onChecked, int checkedId) = OnCheckedPlan;

  const factory SubscriptionV2Event.getServerPlans() = GetServerPlans;

  const factory SubscriptionV2Event.getSubscriptionPlans() = GetSubscriptionPlansV2;

  // const factory SubscriptionV2Event.init() = SubscriptionV2Init;
  //
  // const factory SubscriptionV2Event.checkEligibility() = CheckEligibilityV2;
  //
  // const factory SubscriptionV2Event.errorPurchase(RequestError error) = ErrorPurchaseV2;

  // const factory SubscriptionV2Event.setEligibility({required bool isEligible, PurchaseDetails? purchase}) = SetEligibilityV2;
  //
  // const factory SubscriptionV2Event.canceledByUser() = CanceledByUserV2;
  //
  // const factory SubscriptionV2Event.notifySubscriptionExpired({required Subscription subscription}) = NotifySubscriptionExpiredV2;
  //
  // const factory SubscriptionV2Event.purchasedSubscription(Subscription subscription, PurchasedProductV2 purchasedProduct) = PurchasedSubscriptionV2;
  //
  // const factory SubscriptionV2Event.getActiveSubscriptionV2() = GetActiveSubscriptionV2;

  // const factory SubscriptionV2Event.processingDataPlansV2() = ProcessingDataPlansV2;
  //
  // const factory SubscriptionV2Event.setEligibilityV2({required bool isEligible, PurchaseDetails? purchase}) = SetEligibilityV2;
  //
  // const factory SubscriptionV2Event.verifyLastPurchase(ProductDetails product) = VerifyLastPurchaseV2;
  //
  // const factory SubscriptionV2Event.buySubscription(ProductDetails product) = BuySubscriptionV2;
  //
  // const factory SubscriptionV2Event.purchasedSubscriptionV2(Subscription subscription, PurchasedProductV2 purchasedProduct) = PurchasedSubscriptionV2;
  //
  // const factory SubscriptionV2Event.restorePurchased() = RestorePurchasedV2;
  //
  // const factory SubscriptionV2Event.getAccountSubscription() = GetAccountSubscriptionV2;
  //
  // const factory SubscriptionV2Event.logout() = SubscriptionLogoutV2;
  //
  // const factory SubscriptionV2Event.dispose() = SubscriptionDisposeV2;
}
