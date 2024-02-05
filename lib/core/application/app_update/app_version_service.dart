import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/application/app_update/dto/get_versions_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

abstract class AppVersionService {
  Future<Either<RequestError, GetVersionsResponse>> getVersions();
}
