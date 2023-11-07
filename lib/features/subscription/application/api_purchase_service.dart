import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/account/subscription.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscription/application/purchase_service.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_android.dart';
import 'package:loopcare_frontend/features/subscription/donain/verify_purchase_data_ios.dart';

@Injectable(as: PurchaseService)
class APIPurchaseService implements PurchaseService {
  DioClient client;

  APIPurchaseService(this.client);

  @override
  Future<Either<RequestError, Subscription>> verifyPurchaseIOS(VerifyIOSPurchaseData data, String vendor) async {
    return client.post('/subscription/purchase/$vendor', data: data).then(parseResponse(Subscription.fromJson));
  }

  @override
  Future<Either<RequestError, Subscription>> verifyPurchaseAndroid(
      VerifyAndroidPurchaseData data, String vendor) async {
    return client.post('/subscription/purchase/$vendor', data: data).then(parseResponse(Subscription.fromJson));
  }
}
