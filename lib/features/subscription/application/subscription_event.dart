part of 'subscription_bloc.dart';

@freezed
class SubscriptionEvent with _$SubscriptionEvent {
  const factory SubscriptionEvent.getPlansFromServer() = GetPlansFromServer;
  const factory SubscriptionEvent.getSubscriptionPlans() = GetSubscriptionPlans;

  const factory SubscriptionEvent.processingDataPlans() = ProcessingDataPlans;

  const factory SubscriptionEvent.getActiveSubscription() = GetActiveSubscription;

  const factory SubscriptionEvent.getAccountSubscription() = GetAccountSubscription;

  const factory SubscriptionEvent.verifyLastPurchase(ProductDetails product) = VerifyLastPurchase;

  const factory SubscriptionEvent.buySubscription(ProductDetails product) = BuySubscription;

  const factory SubscriptionEvent.init() = SubscriptionInit;

  const factory SubscriptionEvent.dispose() = SubscriptionDispose;

  const factory SubscriptionEvent.logout() = SubscriptionLogout;

  const factory SubscriptionEvent.purchasedSubscription(
      Subscription subscription, PurchasedProduct purchasedProduct) = PurchasedSubscription;

  const factory SubscriptionEvent.restorePurchased() = RestorePurchased;

  const factory SubscriptionEvent.errorPurchase(RequestError error) = ErrorPurchase;

  const factory SubscriptionEvent.canceledByUser() = CanceledByUser;

  const factory SubscriptionEvent.checkEligibility() = CheckEligibility;

  const factory SubscriptionEvent.setEligibility(
      {required bool isEligible, PurchaseDetails? purchase}) = SetEligibility;

  const factory SubscriptionEvent.notifySubscriptionExpired({required Subscription subscription}) = NotifySubscriptionExpired;
}
