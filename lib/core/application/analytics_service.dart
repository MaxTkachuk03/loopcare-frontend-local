import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/application/dto/send_analytics_event_body.dart';
import 'package:loopcare_frontend/core/application/dto/send_analytics_event_response.dart';

import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

abstract class AnalyticsService {
  Future<Either<RequestError, SendAnalyticsEventResponse>> sendEvent(SendAnalyticsEventBody data);
}
