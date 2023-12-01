import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/domain/account/subscription.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_ios.dart';

abstract class PurchaseService {
  Future<Either<RequestError, Subscription>> purchaseIOS(VerifyIOSPurchaseData receipt, String vendor);

  Future<Either<RequestError, Subscription>> purchaseAndroid(VerifyAndroidPurchaseData receipt, String vendor);

  Future<Either<RequestError, Subscription>> verifyPurchaseIOS(VerifyIOSPurchaseData? receipt, String vendor);

  Future<Either<RequestError, Subscription>> verifyPurchaseAndroid(VerifyAndroidPurchaseData? receipt, String vendor);
}
