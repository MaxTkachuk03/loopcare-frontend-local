import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/activity_tracker/domain/activity_service.dart';
import 'package:loopcare_frontend/features/activity_tracker/application/dto/get_activity_response.dart';
import 'package:loopcare_frontend/features/activity_tracker/application/dto/save_activity_response.dart';

@Injectable(as: ActivityService)
class ApiActivityService implements ActivityService {
  DioClient client;

  ApiActivityService(this.client);

  @override
  Future<Either<RequestError, SaveActivityResponse>> saveActivities(List body) async {
    {
      return await client.post(
        data: body,
        '/activity',
        fromJson: SaveActivityResponse.fromJson,
      );
    }
  }

  @override
  Future<Either<RequestError, ActivityResponse>> getActivities(
      String startDate, String endDate) async {
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll({
      'startDate': startDate,
      'endDate': endDate,
    });
    return await client.get('/activity',
        fromJson: ActivityResponse.fromJson, queryParameters: queryParameters);
  }
}
