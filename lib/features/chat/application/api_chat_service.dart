import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/chat/application/chat_service.dart';
import 'package:loopcare_frontend/features/chat/domain/chat_counter.dart';
import 'package:loopcare_frontend/features/chat/domain/chat_read_pointer.dart';
import 'package:loopcare_frontend/features/chat/domain/group_message.dart';
import 'package:loopcare_frontend/features/chat/domain/list_chat_messages.dart';
import 'package:loopcare_frontend/features/chat/domain/list_group_members.dart';

@Injectable(as: ChatService)
class APIChatService implements ChatService {
  DioClient client;

  APIChatService(this.client);

  @override
  Future<Either<RequestError, ListChatMessages>> getMessages(
      {String? fromMessageId, required int limit, String order = 'DESC'}) {
    return client.get('/chats/messages', queryParameters: {
      ..._qpSL(fromMessageId, limit, order),
    }).then(parseResponse(ListChatMessages.fromJson));
  }

  @override
  Future<Either<RequestError, ListGroupMembers>> getMembers({int? id, required int limit}) {
    return client.get('/chats/members', queryParameters: {
      ..._qpPg(id, limit),
    }).then(parseResponse(ListGroupMembers.fromJson));
  }

  @override
  Future<Either<RequestError, GroupMessage>> sendMessages(GroupMessage message) {
    return client.post('/chats/messages', data: message).then(parseResponse(GroupMessage.fromJson));
  }

  @override
  Future<Either<RequestError, GroupMessage>> removeMessage({required String fromMessageId}) {
    return client.delete('/chats/messages/$fromMessageId').then(parseResponse(GroupMessage.fromJson));
  }

  @override
  Future<Either<RequestError, ChatReadPointer>> readPointer({required String fromMessageId}) {
    return client
        .post('/chats/messages/read-pointer/$fromMessageId', data: {}).then(parseResponse(ChatReadPointer.fromJson));
  }

  @override
  Future<Either<RequestError, ChatCounter>> unreadCount() {
    return client.get('/chats/messages/count/unread').then(parseResponse(ChatCounter.fromJson));
  }

  @override
  static Map<String, dynamic> _qpSL(String? fromMessageId, int limit, String order) {
    return {
      if (fromMessageId != null) 'fromMessageId': fromMessageId,
      'limit': limit,
      'order': order,
    };
  }

  @override
  static Map<String, dynamic> _qpPg(int? id, int? limit) {
    return {
      if (id != null) 'id': id,
      if (id != null) 'limit': limit,
    };
  }
}
