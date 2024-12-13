import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/custom_activity_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/log_program_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/physical_program_response.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/program_list_response.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/dto/physical_activities_preferences_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/dto/physical_activities_preferences_response.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_service.dart';

@Injectable(as: PhysicalActivitiesService)
class APIPhysicalActivitiesService implements PhysicalActivitiesService {
  DioClient client;

  APIPhysicalActivitiesService(this.client);

  @override
  Future<Either<RequestError, PhysicalProgramResponse>> getProgram(int programId) async {
    return await client.get(
      '/physical-activities/programs/$programId',
      fromJson: PhysicalProgramResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, ProgramListResponse>> getProgramsByPreferences({
    String? programType,
    String? programPlace,
    String? programDifficulty,
  }) async {
    Map<String, dynamic>? queryParameters;
    if (programType != null || programPlace != null || programDifficulty != null) {
      queryParameters = {};
    }

    if (programType != null) {
      queryParameters!['type'] = programType;
    }
    if (programPlace != null) {
      queryParameters!['place'] = programPlace;
    }
    if (programDifficulty != null) {
      queryParameters!['difficulty'] = programDifficulty;
    }
    return await client.get(
      '/physical-activities/programs',
      queryParameters: queryParameters,
      fromJson: ProgramListResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, ProgramListResponse>> getProgramsByDate(
      {String? startDate, String? endDate}) async {
    final queryParameters = <String, dynamic>{};
    if (startDate != null && endDate != null) {
      queryParameters.addAll({
        'startDate': startDate,
        'endDate': endDate,
      });
    }

    return await client.get(
      '/physical-activities/calendar',
      queryParameters: queryParameters,
      fromJson: ProgramListResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, PhysicalProgramResponse>> logProgram({
    required int programId,
    required LogProgramBody data,
  }) async {
    return await client.post(
      '/physical-activities/programs/log',
      data: data,
      fromJson: PhysicalProgramResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, PhysicalProgramResponse>> createCustomActivity(
      CustomActivityBody data) async {
    return await client.post(
      '/physical-activities/programs/custom',
      data: data,
      fromJson: PhysicalProgramResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, PhysicalActivitiesPreferencesResponse>> getPreferences() async {
    return await client.get(
      '/physical-activities/preferences',
      fromJson: PhysicalActivitiesPreferencesResponse.fromJson,
    );
  }

  @override
  Future<Either<RequestError, PhysicalActivitiesPreferencesResponse>> setPreferences(
    PhysicalActivitiesPreferencesBody data,
  ) async {
    return await client.post(
      '/physical-activities/preferences',
      data: data,
      fromJson: PhysicalActivitiesPreferencesResponse.fromJson,
    );
  }
}
