import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/dto/answers_body.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/dto/mental_health_tests_response.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/dto/test_results_response.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/mental_health_service.dart';

@Injectable(as: MentalHealthService)
class APIMentalHealthService implements MentalHealthService {
  DioClient client;

  APIMentalHealthService(this.client);

  @override
  Future<Either<RequestError, MentalHealthTestsResponse>> mentalHealthQuestions() async {
    return await client.get(
      '/mental-health/tests',
      fromJson: MentalHealthTestsResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, TestResultsResponse>> getTestResults(AnswersBody answers) async {
    return await client.post(
      '/mental-health/test/interpretation',
      data: answers,
      fromJson: TestResultsResponse.fromJson,
    );
  }
}
