class AppMixpanelEvents {
  const AppMixpanelEvents._();

  static String get loginSuccess => 'user_login_success ';

  static String get loginFail => 'user_login_fail ';
  static String get openSubscriptionScreen => 'user_opens_subscription_screen';
  static String get getTransactionHistoryByUser => 'get_user_transaction_history_store';
  static String get getSubscriptionIdsBackend => 'get_user_subscription_ids_backend';
  static String get getSubscriptionPansStore => 'get_user_subscription_plans_store';
  static String get getUserAvailableSubscriptions => 'get_user_available_subscription_plans';
  static String get getUserAvailableProductsOffers => 'get_user_available_products_offers';
  static String get getUserTapSubscribeBtn => 'user_clicks_subscribe_btn';

  static String get userLastTransactionValidationBackend => 'user_last_transaction_validation';
  static String get userLastTransactionValidationError => 'user_last_transaction_validation_error';
  static String get userLastTransactionValidationSuccess =>
      'user_last_transaction_validation_success';

  static String get userCancelSubscriptionPurchase => 'user_cancel_subscription_purchase';
  static String get userPurchasedSubscription => 'user_purchased_subscription';

  static String get sendValidationPurchaseOnBackend => 'send_validate_purchase_on_backend';
  static String get sendValidationPurchaseOnBackendError =>
      'send_validate_purchase_on_backend_error';
  static String get sendValidationPurchaseOnBackendSuccess =>
      'send_validate_purchase_on_backend_success';

  static String get getAccessTokenWithSubscription => 'get_access_token_with_subscription';
  static String get getAccessTokenWithSubscriptionError =>
      'get_access_token_with_subscription_error';
  static String get getAccessTokenWithSubscriptionSuccess =>
      'get_access_token_with_subscription_success';

  static String get subscriptionPurchaseError => 'subscription_purchase_error';

  static String get userClickRestore => 'user_clicks_restore_purchase';

  static String get appflyerSdkStartError => 'appflyer_sdk_start_error';

  static String get accessTokenSecureStorageError => 'access_token_secure_storage_error';
}
