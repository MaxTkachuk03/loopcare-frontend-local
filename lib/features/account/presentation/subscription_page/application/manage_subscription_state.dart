part of 'manage_subscription_bloc.dart';

@freezed
class ManageSubscriptionState with _$ManageSubscriptionState {
  const factory ManageSubscriptionState.initial(ManageSubscriptionData data) = InitialManageSubscriptionState;

  const factory ManageSubscriptionState.success(ManageSubscriptionData data) = SuccessManageSubscriptionState;

  const factory ManageSubscriptionState.loading(ManageSubscriptionData data) = LoadingManageSubscriptionState;

  const factory ManageSubscriptionState.error(ManageSubscriptionData data) = ErrorManageSubscriptionState;

  const factory ManageSubscriptionState.subscriptionCancelled(ManageSubscriptionData data) =
      ManageSubscriptionCancelled;
}

@freezed
class ManageSubscriptionData with _$ManageSubscriptionData {
  const ManageSubscriptionData._();

  const factory ManageSubscriptionData({
    RequestError? error,
    @Default(false) bool isLoading,
    ProductDetails? plans,
    PurchaseDetails? purchases,
  }) = _ManageSubscriptionData;
}
