import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_model_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_services_v2.dart';
import 'package:loopcare_frontend/features/subscriptionV2/infrastructure/subscription_mock_v2.dart';

@Injectable(as: SubscriptionServicesV2)
class ApiSubscriptionServices implements SubscriptionServicesV2 {
  ApiSubscriptionServices({
    required this.client,
  });
  DioClient client;

  @override
  Future<Either<RequestError, SubscriptionModelV2>> getPlans() async {
    return right(SubscriptionModelV2.fromJson(subscriptions));

    //  return await client.get(
    //   '',
    //   fromJson: SubscriptionModelV2.fromJson,
    // );
  }
}
