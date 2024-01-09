import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_counter.g.dart';

@immutable
@JsonSerializable()
class ChatCounter {
  final int data;

  const ChatCounter({required this.data});

  static ChatCounter fromJson(Map<String, dynamic> json) => _$ChatCounterFromJson(json);

  Map<String, dynamic> toJson() => _$ChatCounterToJson(this);
}
