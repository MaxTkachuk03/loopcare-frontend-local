import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/features/reflections/application/dto/get_reflections_response.dart';
import 'package:loopcare_frontend/features/reflections/application/dto/submit_reflection_body.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_service.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';

@Injectable(as: ReflectionsService)
class APIReflectionsService implements ReflectionsService {
  DioClient client;

  APIReflectionsService(this.client);

  @override
  Future<Either<RequestError, GetReflectionsResponse>> getReflections() async {
    try {
      final response =
          await client.get('/education/reflections', fromJson: GetReflectionsResponse.fromJson);
      log.d('Raw Response: getReflections');
      return response;
    } catch (e, stackTrace) {
      log.w('Error in client.get: $e');
      log.w('Stack Trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<Either<RequestError, Reflection>> saveReflectionAnswer({
    required int reflectionId,
    required SubmitReflectionBody data,
  }) {
    return client.post(
      '/education/reflections/$reflectionId/submit',
      data: data,
      fromJson: Reflection.fromJson,
    );
  }

  @override
  Future<Either<RequestError, Reflection>> updateReflectionAnswer({
    required int reflectionId,
    required SubmitReflectionBody data,
  }) {
    return client.patch(
      '/education/reflections/$reflectionId/submit',
      data: data,
      fromJson: Reflection.fromJson,
    );
  }
}
