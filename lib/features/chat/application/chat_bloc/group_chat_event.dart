part of 'group_chat_bloc.dart';

@freezed
class GroupChatEvent with _$GroupChatEvent {
  const factory GroupChatEvent.init() = ChatEventInit;
  const factory GroupChatEvent.sendMessage({required GroupMessage message}) = SendMessage;
  const factory GroupChatEvent.getMessages({bool? refresh}) = GetMessages;
  const factory GroupChatEvent.getMembers({bool? refresh}) = GetMembers;
  const factory GroupChatEvent.removeMessage({required String fromMessageId}) = RemoveMessages;
}
