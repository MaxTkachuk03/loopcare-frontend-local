import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_message.g.dart';

@immutable
@JsonSerializable()
class GroupMessage {
  final String? id;
  final int? accountId;
  final String? replyMessageId;
  final String? text;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GroupMessage({
    this.id,
    this.accountId,
    this.text,
    this.replyMessageId,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupMessage.sent({
    String? replyMessageId,
    String? text,
  }) {
    return GroupMessage(
      replyMessageId: replyMessageId,
      text: text,
    );
  }

  static GroupMessage fromJson(Map<String, dynamic> json) => _$GroupMessageFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMessageToJson(this);
}
