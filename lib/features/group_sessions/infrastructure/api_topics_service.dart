import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/group_sessions/appliction/dto/group_sessions_response.dart';
import 'package:loopcare_frontend/features/group_sessions/appliction/topics_service.dart';

@Injectable(as: TopicsService)
class APITopicsService implements TopicsService {
  DioClient client;

  APITopicsService(this.client);

  @override
  Future<Either<RequestError, GroupSessionsResponse>> fetchTopics() async {
    return client.get('/group-sessions').then(parseResponse(GroupSessionsResponse.fromJson));
  }
}
