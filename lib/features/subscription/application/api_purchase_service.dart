import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/account/subscription.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_service.dart';
import 'package:loopcare_frontend/features/subscription/donain/server_product_data.dart';
import 'package:loopcare_frontend/features/subscription/donain/valid_status.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_ios.dart';

@Injectable(as: PurchaseService)
class APIPurchaseService implements PurchaseService {
  DioClient client;

  APIPurchaseService(this.client);

  @override
  Future<Either<RequestError, Subscription>> purchaseIOS(VerifyIOSPurchaseData data, String vendor) async {
    return client.post('/subscription/purchase/$vendor', data: data).then(parseResponse(Subscription.fromJson));
  }

  @override
  Future<Either<RequestError, Subscription>> purchaseAndroid(VerifyAndroidPurchaseData data, String vendor) async {
    return client.post('/subscription/purchase/$vendor', data: data).then(parseResponse(Subscription.fromJson));
  }

  @override
  Future<Either<RequestError, ValidStatus>> verifyPurchaseIOS(VerifyIOSPurchaseData? data, String vendor) async {
    return client
        .post('/subscription/purchase/$vendor/validate', data: data ?? {})
        .then(parseResponse(ValidStatus.fromJson));
  }

  @override
  Future<Either<RequestError, ValidStatus>> verifyPurchaseAndroid(
      VerifyAndroidPurchaseData? data, String vendor) async {
    return client
        .post('/subscription/purchase/$vendor/validate', data: data ?? {})
        .then(parseResponse(ValidStatus.fromJson));
  }

  @override
  Future<Either<RequestError, ServerProductData>> getProductList(String vendor) async {
    return client.get('/subscription/products/$vendor').then(parseResponse(ServerProductData.fromJson));
  }
}
