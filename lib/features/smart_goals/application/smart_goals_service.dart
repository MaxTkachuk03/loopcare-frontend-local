import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/get_goals_response.dart';

abstract class SmartGoalsService {
  Future<Either<RequestError, GetGoalsResponse>> getGoals();
}
