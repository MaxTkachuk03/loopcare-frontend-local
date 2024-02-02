import 'package:dartz/dartz.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/chat/domain/chat_counter.dart';
import 'package:loopcare_frontend/features/chat/domain/chat_read_pointer.dart';
import 'package:loopcare_frontend/features/chat/domain/group_message.dart';
import 'package:loopcare_frontend/features/chat/domain/list_chat_messages.dart';
import 'package:loopcare_frontend/features/chat/domain/list_group_members.dart';

abstract class ChatService {
  Future<Either<RequestError, ListChatMessages>> getMessages(
      {String? fromMessageId, required int limit, String order = 'ASC'});

  Future<Either<RequestError, ListGroupMembers>> getMembers();

  Future<Either<RequestError, GroupMessage>> sendMessages(GroupMessage message);

  Future<Either<RequestError, GroupMessage>> removeMessage({required String fromMessageId});

  Future<Either<RequestError, ChatReadPointer>> readPointer({required String fromMessageId});

  Future<Either<RequestError, ChatCounter>> unreadCount();
}
