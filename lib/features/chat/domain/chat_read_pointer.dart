import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_read_pointer.g.dart';

@immutable
@JsonSerializable()
class ChatReadPointer {
  final String chatMessageId;

  const ChatReadPointer({required this.chatMessageId});

  static ChatReadPointer fromJson(Map<String, dynamic> json) => _$ChatReadPointerFromJson(json);

  Map<String, dynamic> toJson() => _$ChatReadPointerToJson(this);
}
