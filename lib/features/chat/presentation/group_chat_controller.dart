import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/chat/domain/chat_mapper_message.dart';
import 'package:loopcare_frontend/features/chat/domain/group_member.dart';
import 'package:loopcare_frontend/features/chat/domain/group_message.dart';

class GroupChatController {
  final GroupChatBloc bloc;
  final types.User user;

  GroupChatController({required this.bloc, required this.user});

  String getNames(GroupChatState state) => state.data.members.map((item) => item.nickname).toList().join(",");

  void handleSendPressed(types.PartialText message) {
    GroupMessage groupMessage = MapperChatMessage.groupMessageMapper(message, user.id);
    bloc.add(GroupChatEvent.sendMessage(message: groupMessage));
  }

  void loadMessages() => bloc.add(const GroupChatEvent.getMessages());

  void loadMembers() => bloc.add(const GroupChatEvent.getMembers());

  void refreshMessages() => bloc.add(const GroupChatEvent.getMessages(refresh: true));

  void refreshMembers() => bloc.add(const GroupChatEvent.getMembers(refresh: true));

  void removedMessage({required String fromMessageId}) =>
      bloc.add(GroupChatEvent.removeMessage(fromMessageId: fromMessageId));

  void setReadPointer({required String fromMessageId}) =>
      bloc.add(GroupChatEvent.setReadPointer(fromMessageId: fromMessageId));

  void getUnreadCount() => bloc.add(const GroupChatEvent.getUnreadCount());

  Future<void> handleEndReached() async => loadMessages();

  List<types.TextMessage> getMessages(List<GroupMessage> list, List<GroupMember> members) =>
      list.map((message) => MapperChatMessage.textMessageMapper(message, members)).toList();
}
