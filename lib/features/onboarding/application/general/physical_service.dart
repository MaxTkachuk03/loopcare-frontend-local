import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/add_physical_survey.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/user_physical_survey_response.dart';

abstract class PhysicalService {
  Future<Either<RequestError, dynamic>> savePhysicalSurvey(AddPhysicalSurvey data);

  Future<Either<RequestError, UserPhysicalSurveyResponse>> getPhysicalSurvey();
}
