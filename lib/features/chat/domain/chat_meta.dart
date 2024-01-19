import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_meta.g.dart';

@immutable
@JsonSerializable()
class ChatMeta {
  final int limit;
  final bool hasNext;

  const ChatMeta({
    required this.limit,
    required this.hasNext,
  });

  static ChatMeta fromJson(Map<String, dynamic> json) => _$ChatMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMetaToJson(this);
}
