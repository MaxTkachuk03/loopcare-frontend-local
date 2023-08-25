import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_sessions_response.dart';

abstract class TopicsService {
  Future<Either<RequestError, GroupSessionsResponse>> fetchTopics();
}
