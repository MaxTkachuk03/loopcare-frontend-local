import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
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
  Future<Either<RequestError, ListChatMessages>> getMessages({
    String? fromMessageId,
    required int limit,
    String order = 'DESC',
  }) async {
    return await client.get(
      '/chats/messages',
      queryParameters: _qpSL(fromMessageId, limit, order),
      fromJson: ListChatMessages.fromJson,
    );
  }

  @override
  Future<Either<RequestError, ListGroupMembers>> getMembers() async {
    return await client.get('/chats/members', fromJson: ListGroupMembers.fromJson);
  }

  @override
  Future<Either<RequestError, GroupMessage>> sendMessages(GroupMessage message) async {
    return await client.post('/chats/messages', data: message, fromJson: GroupMessage.fromJson);
  }

  @override
  Future<Either<RequestError, GroupMessage>> removeMessage({required String fromMessageId}) async {
    return await client.delete('/chats/messages/$fromMessageId', fromJson: GroupMessage.fromJson);
  }

  @override
  Future<Either<RequestError, ChatReadPointer>> readPointer({required String fromMessageId}) async {
    return await client.post(
      '/chats/messages/read-pointer/$fromMessageId',
      fromJson: ChatReadPointer.fromJson,
    );
  }

  @override
  Future<Either<RequestError, ChatCounter>> unreadCount() async {
    return await client.get('/chats/messages/count/unread', fromJson: ChatCounter.fromJson);
  }

  static Map<String, dynamic> _qpSL(String? fromMessageId, int limit, String order) {
    return {
      if (fromMessageId != null) 'fromMessageId': fromMessageId,
      'limit': limit,
      'order': order,
    };
  }
}
