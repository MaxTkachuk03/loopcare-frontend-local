import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_service.dart';
import 'package:loopcare_frontend/features/subscription/domain/server_product_data.dart';
import 'package:loopcare_frontend/features/subscription/domain/valid_status.dart';
import 'package:loopcare_frontend/features/subscription/domain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/domain/verify_purchase_data_ios.dart';

@Injectable(as: PurchaseService)
class APIPurchaseService implements PurchaseService {
  DioClient client;

  APIPurchaseService(this.client);

  @override
  Future<Either<RequestError, Subscription>> purchaseIOS(
      VerifyIOSPurchaseData data, String vendor) async {
    return await client.post(
      '/subscription/purchase/$vendor',
      data: data,
      fromJson: Subscription.fromJson,
    );
  }

  @override
  Future<Either<RequestError, Subscription>> purchaseAndroid(
    VerifyAndroidPurchaseData data,
    String vendor,
  ) async {
    return await client.post(
      '/subscription/purchase/$vendor',
      data: data,
      fromJson: Subscription.fromJson,
    );
  }

  @override
  Future<Either<RequestError, ValidStatus>> verifyPurchaseIOS(
    VerifyIOSPurchaseData? data,
    String vendor,
  ) async {
    return await client.post(
      '/subscription/purchase/$vendor/validate',
      data: data ?? {},
      fromJson: ValidStatus.fromJson,
    );
  }

  @override
  Future<Either<RequestError, ValidStatus>> verifyPurchaseAndroid(
    VerifyAndroidPurchaseData? data,
    String vendor,
  ) async {
    return await client.post(
      '/subscription/purchase/$vendor/validate',
      data: data ?? {},
      fromJson: ValidStatus.fromJson,
    );
  }

  @override
  Future<Either<RequestError, ServerProductData>> getProductList(String vendor) async {
    return await client.get(
      '/subscription/products/$vendor',
      fromJson: ServerProductData.fromJson,
    );
  }
}
