import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'socket_remove_data.g.dart';

@immutable
@JsonSerializable()
class SocketRemoveData {
  final String id;

  const SocketRemoveData({required this.id});

  static SocketRemoveData fromJson(Map<String, dynamic> json) => _$SocketRemoveDataFromJson(json);

  Map<String, dynamic> toJson() => _$SocketRemoveDataToJson(this);
}
