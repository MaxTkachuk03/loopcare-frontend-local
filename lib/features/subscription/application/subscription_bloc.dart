import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/account/subscription.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_details_subscriptions.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_service.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_service.dart';
import 'package:loopcare_frontend/features/subscription/donain/purchased_product.dart';
import 'package:loopcare_frontend/features/subscription/donain/subscription_state.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_ios.dart';
import 'package:loopcare_frontend/features/subscription/utils/date_utils.dart';

import '../../../injection.dart';

part 'subscription_bloc.freezed.dart';
part 'subscription_event.dart';
part 'subscription_state.dart';

@singleton
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  late PurchaseDetailsStreamSubscription purchaseDetailsStreamSubscription;
  final inAppPurchaseService = getIt<AppSubscriptionService>();
  final AuthenticationService _authenticationService;
  final PurchaseService _purchaseService;
  bool isValidatePastIOSPurchase = true;
  ProductDetails? buyingProduct;

  SubscriptionBloc(this._authenticationService, this._purchaseService)
      : super(const SubscriptionState.initial(SubscriptionStateData())) {
    on<SubscriptionInit>(_onInitSubscription);
    on<SubscriptionDispose>(_onSubscriptionDispose);
    on<BuySubscription>(_onBuySubscription);
    on<VerifyLastPurchase>(_onVerifyLastPurchase);
    on<RestorePurchased>(_onRestorePurchased);
    on<PurchasedSubscription>(_onPurchasedSubscription);
    on<ErrorVerifyPurchase>(_onErrorVerifyPurchase);
    on<GetActiveSubscription>(_onGetActiveSubscription);
    on<GetSubscriptionPlans>(_onGetSubscriptionPlans);
    purchaseDetailsStreamSubscription = PurchaseDetailsStreamSubscription(
      onCanceled: () => debugPrint('devcpp Subscription Canceled'),
      onError: (error) => isValidatePastIOSPurchase
          ? add(SubscriptionEvent.buySubscription(buyingProduct!))
          : add(SubscriptionEvent.errorVerifyPurchase(error)),
      onRestored: (purchase) async => _restoreTransactionData(purchase),
      onPurchased: (PurchaseDetails purchaseDetails) async => _handlePurchase(purchaseDetails),
    )..init();
  }

  FutureOr<void> _onVerifyLastPurchase(
    VerifyLastPurchase event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    _getOldPurchase(event.product);
  }

  FutureOr<void> _onBuySubscription(
    BuySubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    debugPrint('devcpp Buy request: ${event.product.id}');
    final response = await inAppPurchaseService.buyItemInStore(event.product);
    debugPrint('devcpp Buy response: ${response.toString()}');
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    debugPrint('devcpp _handlePurchase');
    try {
      if (purchaseDetails.pendingCompletePurchase) {
        debugPrint('devcpp  CompletePurchase product ID: ${purchaseDetails.productID}');
        await inAppPurchaseService.instance.completePurchase(purchaseDetails);
      }
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        await _verifyNewPurchase(purchaseDetails);
      }
    } catch (_, __) {}
  }

  Future<void> _verifyNewPurchase(PurchaseDetails purchaseDetails) async {
    debugPrint('devcpp _verifyNewPurchase');
    final response = await _apiVerified(purchaseDetails);
    response.fold((error) {
      debugPrint('devcpp error VerifyPurchaseData: $error');
      add(SubscriptionEvent.errorVerifyPurchase(error));
    }, (r) async {
      debugPrint('devcpp succeed VerifyPurchaseData: ${r.toString()}');
      await inAppPurchaseService.instance.completePurchase(purchaseDetails);
      add(SubscriptionEvent.purchasedSubscription(PurchasedProduct(
        purchaseDetails: purchaseDetails,
        memberSince: SubscriptionDateUtils.getTransactionDate(r.purchasedAt),
      )));
    });
  }

  Future<void> _verifyOldPurchase(PurchaseDetails oldPurchaseDetails, ProductDetails product) async {
    isValidatePastIOSPurchase = false;
    final response = await _apiVerified(oldPurchaseDetails);
    response.fold((error) {
      debugPrint('devcpp error Old VerifyPurchaseData: $error');
      add(SubscriptionEvent.errorVerifyPurchase(error));
    }, (r) {
      add(SubscriptionEvent.buySubscription(product));
    });
  }

  Future<Either<RequestError, Subscription>> _apiVerified(PurchaseDetails purchaseDetails) async {
    var isIOS = purchaseDetails is AppStorePurchaseDetails;
    final vendor = isIOS ? 'ios' : 'android';
    final identifier = _getTransactionId(purchaseDetails) ?? '';
    debugPrint('devcpp _apiVerified TransactionId: $identifier');
    var response = isIOS
        ? await _purchaseService.verifyPurchaseIOS(
            VerifyIOSPurchaseData(
                receipt: purchaseDetails.verificationData.serverVerificationData, transactionId: identifier),
            vendor)
        : await _purchaseService.verifyPurchaseAndroid(
            VerifyAndroidPurchaseData(
                receipt: purchaseDetails.verificationData.serverVerificationData, purchaseToken: identifier),
            vendor);
    debugPrint('devcpp _apiVerified: ${response.toString()}');
    return response;
  }

  void _restoreTransactionData(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.restored) {
      if (isValidatePastIOSPurchase) {
        if (buyingProduct == null) {
          return;
        }
        await _verifyOldPurchase(purchaseDetails, buyingProduct!);
      } else {
        await _verifyNewPurchase(purchaseDetails);
      }
    }
  }

  void _getOldPurchase(ProductDetails product) async {
    PurchaseDetails oldPurchaseDetails;
    if (Platform.isAndroid) {
      {
        final InAppPurchaseAndroidPlatformAddition androidAddition =
            inAppPurchaseService.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
        final QueryPurchaseDetailsResponse oldPurchases = await androidAddition.queryPastPurchases();
        oldPurchaseDetails = oldPurchases.pastPurchases.last;
        await _verifyOldPurchase(oldPurchaseDetails, product);
      }
    } else {
      buyingProduct = product;
      inAppPurchaseService.instance.restorePurchases();
    }
  }

  String? _getTransactionId(PurchaseDetails purchaseDetails) {
    if (purchaseDetails is AppStorePurchaseDetails) {
      final transactionIdentifier = purchaseDetails.skPaymentTransaction.transactionIdentifier;
      final purchaseID = transactionIdentifier;
      debugPrint('devcpp  status: iOS transactionIdentifier -> ${purchaseDetails.productID} -> $purchaseID');
      return purchaseID;
    } else if (purchaseDetails is GooglePlayPurchaseDetails) {
      final originalBilling = purchaseDetails.billingClientPurchase;
      debugPrint(
          'devcpp  status: Google   purchaseToken & orderId -> ${originalBilling.purchaseToken} -> ${originalBilling.orderId}');
      return originalBilling.purchaseToken;
    }
  }

  FutureOr<void> _onPurchasedSubscription(
    PurchasedSubscription event,
    Emitter<SubscriptionState> emit,
  ) async =>
      emit(SubscriptionState.purchasedSubscription(state.data.copyWith(
        purchased: event.purchasedProduct,
        isLoading: false,
      )));

  FutureOr<void> _onErrorVerifyPurchase(
    ErrorVerifyPurchase event,
    Emitter<SubscriptionState> emit,
  ) async =>
      emit(SubscriptionState.error(state.data.copyWith(
        error: event.error,
        isLoading: false,
      )));

  FutureOr<void> _onRestorePurchased(
    RestorePurchased event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    debugPrint('devcpp  _onRestorePurchased');
    isValidatePastIOSPurchase = false;
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    inAppPurchaseService.restorePurchase();
  }

  FutureOr<void> _onGetSubscriptionPlans(
    GetSubscriptionPlans event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    final inAppPurchaseService = getIt<AppSubscriptionService>();
    final plans = await inAppPurchaseService.getSubscriptionPlans();
    emit(
      SubscriptionState.successInPlans(state.data.copyWith(isLoading: false, plans: plans)),
    );
    add(const SubscriptionEvent.getActiveSubscription());
  }

  FutureOr<void> _onGetActiveSubscription(
    GetActiveSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      SubscriptionState.loading(state.data.copyWith(isLoading: true)),
    );
    final response = await _authenticationService.fetchAccount();
    response.fold(
      (error) {
        emit(SubscriptionState.error(state.data.copyWith(error: error, isLoading: false)));
      },
      (r) {
        final subscription = r.subscription;
        final status = SubscriptionStatusUtil.parse(subscription.state);
        emit(
          SubscriptionState.loading(state.data.copyWith(isLoading: false)),
        );
        debugPrint('devcpp SubscriptionStatus: ${subscription.state}');
        switch (status) {
          case SubscriptionStatus.trialPeriod:
            if (subscription.isActive) {
              emit(SubscriptionState.subscriptionActive(state.data.copyWith(subscription: subscription)));
            } else if (!subscription.isActive && SubscriptionDateUtils.isPassDate(subscription.expiresAt)) {
              emit(SubscriptionState.subscriptionEnded(state.data.copyWith(subscription: subscription)));
            } else {
              emit(SubscriptionState.trial(state.data.copyWith(subscription: subscription)));
            }
            break;
          case SubscriptionStatus.common:
            if (!subscription.isActive && SubscriptionDateUtils.isPassDate(subscription.expiresAt)) {
              emit(SubscriptionState.subscriptionEnded(state.data.copyWith(subscription: subscription)));
            } else if (subscription.isActive) {
              emit(SubscriptionState.subscriptionActive(state.data.copyWith(subscription: subscription)));
            } else {
              emit(SubscriptionState.trialExpired(state.data.copyWith(subscription: subscription)));
            }
            break;
          case SubscriptionStatus.cancelled:
            if (SubscriptionDateUtils.isPassDate(subscription.expiresAt) || !subscription.isActive) {
              // if cancelled by user  and expired time => status: Ended
              emit(SubscriptionState.subscriptionEnded(state.data.copyWith(subscription: subscription)));
            } else if (subscription.isActive) {
              emit(SubscriptionState.subscriptionActive(state.data.copyWith(subscription: subscription)));
            }
            break;
          case SubscriptionStatus.refunded:
            emit(SubscriptionState.subscriptionCancelled(state.data.copyWith(subscription: subscription)));
            break;

          case SubscriptionStatus.gracePeriod:
            if (subscription.isActive) {
              emit(SubscriptionState.subscriptionUnRenewed(state.data.copyWith(subscription: subscription)));
            } else {
              emit(SubscriptionState.subscriptionEnded(state.data.copyWith(subscription: subscription)));
            }
            break;
          default:
            emit(SubscriptionState.trial(state.data.copyWith(subscription: subscription)));
        }
      },
    );
  }

  FutureOr<void> _onInitSubscription(
    SubscriptionInit event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionState.initial(SubscriptionStateData()));
  }

  FutureOr<void> _onSubscriptionDispose(
    SubscriptionDispose event,
    Emitter<SubscriptionState> emit,
  ) {
    purchaseDetailsStreamSubscription.close();
    emit(SubscriptionState.success(state.data));
  }
}
