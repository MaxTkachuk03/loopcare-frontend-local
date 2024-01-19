import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/chat/domain/chat_meta.dart';
import 'package:loopcare_frontend/features/chat/domain/group_message.dart';

part 'list_chat_messages.g.dart';

@immutable
@JsonSerializable()
class ListChatMessages {
  final List<GroupMessage> data;
  final ChatMeta meta;

  const ListChatMessages({
    @Default([]) required this.data,
    required this.meta,
  });

  static ListChatMessages fromJson(Map<String, dynamic> json) => _$ListChatMessagesFromJson(json);

  Map<String, dynamic> toJson() => _$ListChatMessagesToJson(this);
}
