// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'socket_data.freezed.dart';
part 'socket_data.g.dart';

@freezed
abstract class SocketData with _$SocketData {
  const factory SocketData({
    @Default('') String qwerty,
  }) = _SocketData;

  factory SocketData.fromJson(Map<String, dynamic> json) => _$SocketDataFromJson(json);
}
