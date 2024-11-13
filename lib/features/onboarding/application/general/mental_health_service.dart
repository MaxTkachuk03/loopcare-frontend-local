import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/answers_body.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/mental_health_tests_response.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/test_results_response.dart';

abstract class MentalHealthService {
  Future<Either<RequestError, MentalHealthTestsResponse>> mentalHealthQuestions();

  Future<Either<RequestError, TestResultsResponse>> getTestResults(AnswersBody answers);
}
