import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/reflections/application/dto/get_reflections_response.dart';
import 'package:loopcare_frontend/features/reflections/application/dto/submit_reflection_body.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';

abstract class ReflectionsService {
  Future<Either<RequestError, GetReflectionsResponse>> getReflections();

  Future<Either<RequestError, Reflection>> saveReflectionAnswer({
    required int reflectionId,
    required SubmitReflectionBody data,
  });

  Future<Either<RequestError, Reflection>> updateReflectionAnswer({
    required int reflectionId,
    required SubmitReflectionBody data,
  });
}
