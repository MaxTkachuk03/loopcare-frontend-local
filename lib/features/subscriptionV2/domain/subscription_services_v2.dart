import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/subscriptionV2/domain/subscription_model_v2.dart';

abstract class SubscriptionServicesV2 {
  Future<Either<RequestError, SubscriptionModelV2>> getPlans();
}