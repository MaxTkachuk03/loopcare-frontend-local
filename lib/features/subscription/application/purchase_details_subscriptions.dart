import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '../../../injection.dart';

class PurchaseDetailsStreamSubscription {
  final AppSubscriptionService inAppPurchaseService = getIt<AppSubscriptionService>();
  final Function()? onPending;
  final Function(PurchaseDetails purchaseDetails)? onPurchased;
  final Function()? onError;
  final Function()? onRestored;
  final Function()? onCanceled;

  StreamSubscription<List<PurchaseDetails>>? _streamSubscription;

  PurchaseDetailsStreamSubscription({
    this.onPending,
    this.onPurchased,
    this.onError,
    this.onRestored,
    this.onCanceled,
  });

  Future<void> init() async {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      inAppPurchaseService.instance
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    _streamSubscription = inAppPurchaseService.storeSubscription.listen(
      (List<PurchaseDetails> events) {
        Future.forEach(
          events,
          (PurchaseDetails purchaseDetails) async {
            switch (purchaseDetails.status) {
              case PurchaseStatus.pending:
                onPending?.call();
                break;
              case PurchaseStatus.restored:
              case PurchaseStatus.purchased:
                onPurchased?.call(purchaseDetails);
                break;
              case PurchaseStatus.error:
                onError?.call();
                break;
              case PurchaseStatus.canceled:
                onCanceled?.call();
                break;
            }
          },
        );
      },
      onDone: () => close(),
      onError: (e) {
        debugPrint('devcpp _streamSubscription ERROR: ${e.toString()}');
        close();
      },
    );
  }

  void close() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      inAppPurchaseService.instance
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _streamSubscription?.cancel();
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
