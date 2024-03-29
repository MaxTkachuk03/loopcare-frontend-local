import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/dto/add_physical_survey.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/dto/user_physical_survey_response.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/physical_service.dart';

@Injectable(as: PhysicalService)
class APIPhysicalService implements PhysicalService {
  DioClient client;

  APIPhysicalService(this.client);

  @override
  Future<Either<RequestError, dynamic>> savePhysicalSurvey(AddPhysicalSurvey data) async {
    return client.post(
      '/fitness/physical',
      data: data,
    );
  }

  @override
  Future<Either<RequestError, UserPhysicalSurveyResponse>> getPhysicalSurvey() async {
    return client.get('/fitness/physical').then(parseResponse(UserPhysicalSurveyResponse.fromJson));
  }
}
