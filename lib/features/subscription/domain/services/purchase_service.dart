import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/subscription/domain/server_product_data.dart';
import 'package:loopcare_frontend/features/subscription/domain/valid_status.dart';
import 'package:loopcare_frontend/features/subscription/domain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/domain/verify_purchase_data_ios.dart';

abstract class PurchaseService {
  Future<Either<RequestError, Subscription>> purchaseIOS(
      VerifyIOSPurchaseData receipt, String vendor);

  Future<Either<RequestError, Subscription>> purchaseAndroid(
      VerifyAndroidPurchaseData receipt, String vendor);

  Future<Either<RequestError, ValidStatus>> verifyPurchaseIOS(
      VerifyIOSPurchaseData? receipt, String vendor);

  Future<Either<RequestError, ValidStatus>> verifyPurchaseAndroid(
      VerifyAndroidPurchaseData? receipt, String vendor);

  Future<Either<RequestError, ServerProductData>> getProductList(String vendor);
}
