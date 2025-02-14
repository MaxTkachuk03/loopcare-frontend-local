import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/activity_tracker/application/dto/get_activity_response.dart';
import 'package:loopcare_frontend/features/activity_tracker/application/dto/save_activity_response.dart';

abstract class ActivityService {
  Future<Either<RequestError, SaveActivityResponse>> saveActivities(List body);

  Future<Either<RequestError, ActivityResponse>> getActivities(String startDate, String endDate);
}
