import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/analytics_service.dart';
import 'package:loopcare_frontend/core/application/dto/send_analytics_event_body.dart';
import 'package:loopcare_frontend/core/application/dto/send_analytics_event_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

@Injectable(as: AnalyticsService)
class APIAnalyticsService implements AnalyticsService {
  DioClient client;

  APIAnalyticsService(this.client);

  @override
  Future<Either<RequestError, SendAnalyticsEventResponse>> sendEvent(SendAnalyticsEventBody data) {
    return client.post('/analytics', data: data).then(parseResponse(SendAnalyticsEventResponse.fromJson));
  }
}
