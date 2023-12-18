import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:loopcare_frontend/features/subscription/utils/date_utils.dart';

import '../../../injection.dart';

class PurchaseDetailsStreamSubscription {
  final AppSubscriptionService inAppPurchaseService = getIt<AppSubscriptionService>();
  final Function()? onPending;
  final Function(PurchaseDetails purchaseDetails)? onPurchased;
  final Function(RequestError error)? onError;
  final Function(PurchaseDetails purchase)? onRestored;
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
          inAppPurchaseService.instance.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(AppPaymentQueueDelegate());
    }
    _streamSubscription = inAppPurchaseService.storeSubscription.listen(
      (List<PurchaseDetails> events) {
        if (events.isEmpty) {
          onError?.call(const RequestError.streamSubscription('Something went wrong with service, please try again'));
          return;
        }
        if (events.every((element) => element.status == PurchaseStatus.restored)) {
          debugPrint('devcpp RESTORED: ${events.length} ');
          events.sort((a, b) => int.parse(a.transactionDate!).compareTo(int.parse(b.transactionDate!)));
          debugPrint(
              'devcpp RESTORED PURCHASE: ${SubscriptionDateUtils.getTransactionFromMillisecondsSinceEpoch(events.last.transactionDate!)} ');
          onRestored?.call(events.last);
        } else {
          Future.forEach(
            events,
            (PurchaseDetails purchaseDetails) async {
              switch (purchaseDetails.status) {
                case PurchaseStatus.pending:
                  onPending?.call();
                  break;
                case PurchaseStatus.purchased:
                  onPurchased?.call(purchaseDetails);
                  break;
                case PurchaseStatus.canceled:
                  onCanceled?.call();
                  break;
                case PurchaseStatus.restored:
                  break;
                case PurchaseStatus.error:
                  debugPrint('devcpp  Service ERROR: ${purchaseDetails.error?.toString()}');
                  onError?.call(const RequestError.streamSubscription('Something went wrong, please try again'));
                  break;
              }
            },
          );
        }
      },
      onDone: () => close(),
      onError: (e) {
        close();
      },
    );
  }

  void close() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchaseService.instance.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
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
class AppPaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
