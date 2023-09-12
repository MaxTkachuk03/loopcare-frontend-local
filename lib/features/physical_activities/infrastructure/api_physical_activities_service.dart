import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/custom_activity_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/log_program_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/physical_program_response.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/program_list_response.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/dto/physical_activities_preferences_response.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/dto/physical_activities_preferences_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_service.dart';

@Injectable(as: PhysicalActivitiesService)
class APIPhysicalActivitiesService implements PhysicalActivitiesService {
  DioClient client;

  APIPhysicalActivitiesService(this.client);

  @override
  Future<Either<RequestError, PhysicalProgramResponse>> getProgram(int programId) {
    return client
        .get('/physical-activities/programs/$programId')
        .then(parseResponse(PhysicalProgramResponse.fromJson));
  }

  @override
  Future<Either<RequestError, ProgramListResponse>> getProgramsByPreferences({
    required String programType,
    required String programPlace,
    required String programDifficulty,
  }) {
    return client.get(
      '/physical-activities/programs',
      queryParameters: {
        'type': programType,
        'place': programPlace,
        'difficulty': programDifficulty,
      },
    ).then(parseResponse(ProgramListResponse.fromJson));
  }

  @override
  Future<Either<RequestError, ProgramListResponse>> getProgramsByDate({String? startDate, String? endDate}) {
    final queryParameters = <String, dynamic>{};
    if (startDate != null && endDate != null) {
      queryParameters.addAll({
        'startDate': startDate,
        'endDate': endDate,
      });
    }

    return client
        .get('/physical-activities/calendar', queryParameters: queryParameters)
        .then(parseResponse(ProgramListResponse.fromJson));
  }

  @override
  Future<Either<RequestError, PhysicalProgramResponse>> logProgram({
    required int programId,
    required LogProgramBody data,
  }) {
    return client
        .post('/physical-activities/programs/log', data: data)
        .then(parseResponse(PhysicalProgramResponse.fromJson));
  }

  @override
  Future<Either<RequestError, PhysicalProgramResponse>> createCustomActivity(CustomActivityBody data) {
    return client
        .post('/physical-activities/programs/custom', data: data)
        .then(parseResponse(PhysicalProgramResponse.fromJson));
  }

  @override
  Future<Either<RequestError, PhysicalActivitiesPreferencesResponse>> getPreferences() {
    return client
        .get('/physical-activities/preferences')
        .then(parseResponse(PhysicalActivitiesPreferencesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, PhysicalActivitiesPreferencesResponse>> setPreferences(
      PhysicalActivitiesPreferencesBody data) {
    return client
        .post('/physical-activities/preferences', data: data)
        .then(parseResponse(PhysicalActivitiesPreferencesResponse.fromJson));
  }
}
