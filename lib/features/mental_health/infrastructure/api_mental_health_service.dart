import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/mental_health/application/dto/answers_body.dart';
import 'package:loopcare_frontend/features/mental_health/application/dto/mental_health_tests_response.dart';
import 'package:loopcare_frontend/features/mental_health/application/dto/test_results_response.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_service.dart';

@Injectable(as: MentalHealthService)
class APIMentalHealthService implements MentalHealthService {
  DioClient client;

  APIMentalHealthService(this.client);

  @override
  Future<Either<RequestError, MentalHealthTestsResponse>> mentalHealthQuestions() async {
    return client
        .get('/mental-health/tests')
        .then(parseResponse(MentalHealthTestsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, TestResultsResponse>> getTestResults(AnswersBody answers) async {
    return client
        .post('/mental-health/test/interpretation', data: answers)
        .then(parseResponse(TestResultsResponse.fromJson));
  }
}
