import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:loopcare_frontend/features/chat/domain/group_member.dart';
import 'package:loopcare_frontend/features/chat/domain/group_message.dart';

class MapperChatMessage {
  static types.TextMessage textMessageMapper(GroupMessage message, List<GroupMember> members) {
    String nikName = '';
    for (final entity in members) {
      if (message.accountId == entity.accountId) {
        nikName = entity.nickname ?? '';
      }
    }
    return types.TextMessage(
      id: message.id!,
      author: types.User(
        id: '${message.accountId}',
        firstName: nikName,
      ),
      type: types.MessageType.text,
      text: message.text ?? '',
      createdAt: message.createdAt?.millisecondsSinceEpoch,
    );
  }

  static GroupMessage groupMessageMapper(types.PartialText message, String id) {
    return GroupMessage.sent(
      // replyMessageId: id,
      text: message.text,
    );
  }
}
