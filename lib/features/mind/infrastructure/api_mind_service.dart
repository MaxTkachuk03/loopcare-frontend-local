import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique_exercises_response.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_techniques_response.dart';
import 'package:loopcare_frontend/features/mind/application/mind_service.dart';

// TODO import mock data
import 'techniques_mock.dart';

@Injectable(as: MindService)
class APIMindService implements MindService {
  DioClient client;

  APIMindService(this.client);

  @override
  Future<Either<RequestError, MindTechniquesResponse>> getTechniques() async {
    // TODO use to mock program server response
    return right(MindTechniquesResponse.fromJson(program));

    // return client.get('/mind/techniques').then(parseResponse(MindTechniquesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, MindTechniqueExercisesResponse>> getTechniquesExercises(int techniqueId) async {
    return client.put('/mind/techniques/$techniqueId/exercises').then(parseResponse(MindTechniqueExercisesResponse.fromJson));
  }

  @override
  Future<Either<RequestError, dynamic>> completeExercise(int techniqueId, int exerciseId) async {
    return client.delete('/mind/techniques/$techniqueId/exercises/$exerciseId/complete');
  }
}
