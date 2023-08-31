import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/empty_response.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/fetch_session_data.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/get_session_signature_response.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_sessions_response.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/sign_to_group_session_response.dart';

abstract class TopicsService {
  Future<Either<RequestError, GroupSessionsResponse>> fetchTopics(FetchSessionData data);

  Future<Either<RequestError, SignToGroupSessionsResponse>> signToGroupMeeting(int groupSessionId);

  Future<Either<RequestError, EmptyResponse>> signOutGroupMeeting(int groupSessionId);

  Future<Either<RequestError, GetSessionSignatureResponse>> getSessionSignature(int sessionId);
}
