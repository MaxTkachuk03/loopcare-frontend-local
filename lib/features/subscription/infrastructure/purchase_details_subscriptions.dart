import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/server_error_data.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/subscription/infrastructure/subscription_service.dart';
import 'package:loopcare_frontend/injection.dart';

class PurchaseDetailsStreamSubscription {
  final AppSubscriptionService inAppPurchaseService = getIt<AppSubscriptionService>();
  final Function()? onPending;
  final Function(PurchaseDetails purchaseDetails)? onPurchased;
  final Function(RequestError error)? onError;
  final Function(PurchaseDetails purchase)? onRestored;
  final Function()? onCanceled;
  final Function()? onEmpty;

  StreamSubscription<List<PurchaseDetails>>? _streamSubscription;

  PurchaseDetailsStreamSubscription({
    this.onPending,
    this.onPurchased,
    this.onEmpty,
    this.onError,
    this.onRestored,
    this.onCanceled,
  });

  Future<void> init() async {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = inAppPurchaseService
          .instance
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(AppPaymentQueueDelegate());
    }
    _streamSubscription = inAppPurchaseService.storeSubscription.listen(
      _streamListener,
      onDone: close,
      onError: (e) {
        onError?.call(const RequestError.streamSubscription(
            ServerErrorData(message: LocalizedTexts.errorPurchaseStreamError)));
        close();
      },
    );
  }

  void _streamListener(List<PurchaseDetails> events) async {
    if (events.isEmpty) {
      onEmpty?.call();
      return;
    }
    if (events.every((element) => element.status == PurchaseStatus.restored)) {
      events.sort((a, b) => int.parse(a.transactionDate!).compareTo(int.parse(b.transactionDate!)));

      for (var purchaseDetails in events) {
        await inAppPurchaseService.completePurchase(purchaseDetails);
      }
      onRestored?.call(events.last);
      if (Platform.isIOS) {
        await inAppPurchaseService.finishTransactionIOS();
      }
      return;
    }
    Future.forEach(
      events,
      (PurchaseDetails purchaseDetails) async {
        switch (purchaseDetails.status) {
          case PurchaseStatus.pending:
            break;
          case PurchaseStatus.purchased:
            onPurchased?.call(purchaseDetails);
            if (Platform.isIOS) {
              await inAppPurchaseService.finishTransactionIOS();
            }
            break;
          case PurchaseStatus.canceled:
            onCanceled?.call();
            break;
          case PurchaseStatus.error:
            // TODO handle this type error IAPError? error;
            onError?.call(const RequestError.streamSubscription(
                ServerErrorData(message: LocalizedTexts.errorPurchaseStreamError)));
            if (Platform.isIOS) {
              await inAppPurchaseService.finishTransactionIOS();
            }
            break;
          default:
            break;
        }
        await inAppPurchaseService.completePurchase(purchaseDetails);
      },
    );
  }

  void close() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = inAppPurchaseService
          .instance
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
class AppPaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
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
