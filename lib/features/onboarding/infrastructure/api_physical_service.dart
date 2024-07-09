import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/add_physical_survey.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/user_physical_survey_response.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/physical_service.dart';

@Injectable(as: PhysicalService)
class APIPhysicalService implements PhysicalService {
  DioClient client;

  APIPhysicalService(this.client);

  // dynamic map
  @override
  Future<Either<RequestError, dynamic>> savePhysicalSurvey(AddPhysicalSurvey data) async {
    return await client.post(
      '/fitness/physical',
      data: data,
    );
  }

  @override
  Future<Either<RequestError, UserPhysicalSurveyResponse>> getPhysicalSurvey() async {
    return await client.get(
      '/fitness/physical',
      fromJson: UserPhysicalSurveyResponse.fromJson,
    );
  }
}
