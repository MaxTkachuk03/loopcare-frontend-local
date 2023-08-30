import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/get_session_signature_response.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_sessions_response.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/sign_to_group_session_response.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_service.dart';

@Injectable(as: TopicsService)
class APITopicsService implements TopicsService {
  DioClient client;

  APITopicsService(this.client);

  @override
  Future<Either<RequestError, GroupSessionsResponse>> fetchTopics() async {
    return client.get('/group-sessions').then(parseResponse(GroupSessionsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, SignToGroupSessionsResponse>> signToGroupMeeting(int groupSessionId) {
    return client.post(
      '/group-sessions/$groupSessionId/members',
      data: {},
    ).then(parseResponse(SignToGroupSessionsResponse.fromJson));
  }

  @override
  Future<Either<RequestError, GetSessionSignatureResponse>> getSessionSignature(int sessionId) async {
    return client
        .get('/group-sessions/$sessionId/signature')
        .then(parseResponse(GetSessionSignatureResponse.fromJson));
  }
}
