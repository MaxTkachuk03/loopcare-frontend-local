import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/server_product_data_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/valid_status_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/verify_purchase_data_android_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/verify_purchase_data_ios_v2.dart';

abstract class PurchaseServiceV2 {
  Future<Either<RequestError, Subscription>> purchaseIOSV2(
      VerifyIOSPurchaseDataV2 receipt, String vendor);

  Future<Either<RequestError, Subscription>> purchaseAndroidV2(
      VerifyAndroidPurchaseDataV2 receipt, String vendor);

  Future<Either<RequestError, ValidStatusV2>> verifyPurchaseIOSV2(
      VerifyIOSPurchaseDataV2? receipt, String vendor);

  Future<Either<RequestError, ValidStatusV2>> verifyPurchaseAndroidV2(
      VerifyAndroidPurchaseDataV2? receipt, String vendor);

  Future<Either<RequestError, ServerProductDataV2>> getProductListV2(String vendor);
}
