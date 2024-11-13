import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/mind/application/dto/complete_exercise_data.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_info_response.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique_exercise.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique_exercises_response.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_techniques_response.dart';

abstract class MindService {
  Future<Either<RequestError, MindInfoResponse>> getMindInfo();

  Future<Either<RequestError, MindTechniquesResponse>> getTechniques();

  Future<Either<RequestError, MindTechniqueExercisesResponse>> getTechniquesExercises(
      int techniqueId);

  Future<Either<RequestError, MindTechniqueExercise>> completeExercise(
      int techniqueId, int exerciseId,
      {required CompleteExerciseData data});
}
