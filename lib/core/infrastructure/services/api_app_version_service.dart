import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/app_update/app_version_service.dart';
import 'package:loopcare_frontend/core/application/app_update/dto/get_versions_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

@Injectable(as: AppVersionService)
class APIAppVersionService implements AppVersionService {
  late final Dio dio;

  APIAppVersionService() {
    dio = dioOptions;
  }

  @override
  Future<Either<RequestError, GetVersionsResponse>> getVersions() async {
    return await fetchResponse(
      dio,
      '/versions',
      FetchType.get,
      fromJson: (r) => GetVersionsResponse.fromJson(r),
    );
  }
}
