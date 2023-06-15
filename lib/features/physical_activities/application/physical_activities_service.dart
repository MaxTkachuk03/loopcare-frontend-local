import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/log_program_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/physical_program_response.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/custom_activity_body.dart';
import 'package:loopcare_frontend/features/physical_activities/application/dto/program_list_response.dart';

abstract class PhysicalActivitiesService {
  Future<Either<RequestError, ProgramListResponse>> getProgramsByCategory({
    required String programType,
    required String programPlace,
    required String programDifficulty,
  });
  Future<Either<RequestError, ProgramListResponse>> getProgramsByDate({
    String? startDate,
    String? endDate,
  });

  Future<Either<RequestError, PhysicalProgramResponse>> getProgram(int programId);

  Future<Either<RequestError, PhysicalProgramResponse>> logProgram({
    required int programId,
    required LogProgramBody data
  });

  Future<Either<RequestError, PhysicalProgramResponse>> createCustomActivity(CustomActivityBody data);
}
