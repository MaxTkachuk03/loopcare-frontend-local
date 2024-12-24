import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

abstract class DeleteGoalServices {
  Future<Either<RequestError, dynamic>> deleteMultipleGoal({required List<int> sessionIds});
}
