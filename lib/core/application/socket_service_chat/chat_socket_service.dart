import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/socket_service/events.dart';
import 'package:loopcare_frontend/core/application/socket_service_chat/chat_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/chat/domain/group_message.dart';
import 'package:loopcare_frontend/features/chat/domain/socket_remove_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatSocketService {
  final AppConfig? _appConfig;
  final GroupChatBloc? _chatBloc;
  final AuthTokenManager? _tokenManager;

  String? _baseUrl;
  io.Socket? _socket;
  static final ChatSocketService _instance = ChatSocketService._internal();

  static ChatSocketService get instance => _instance;

  ChatSocketService._internal()
      : _appConfig = GetIt.instance<AppConfig>(),
        _tokenManager = GetIt.instance<AuthTokenManager>(),
        _chatBloc = GetIt.instance<GroupChatBloc>() {
    _baseUrl = 'wss://${_appConfig?.baseHost}/chat';
  }

  Future<void> startListen() async {
    final token = await _initToken();
    if (token == null) return;

    if (_socket == null) {
      _initSocket(token);
    } else {
      connect(token);
    }
  }

  Future<String?> _initToken() async {
    final token = await _tokenManager?.getAccessToken();

    if (token == null) {
      disconnect();
      return null;
    }

    return token;
  }

  bool get isConnected => _socket?.connected ?? false;

  void disconnect() {
    _socket?.disconnect();
  }

  void connect(String token) {
    _socket?.io.options!['authorization'] = {'Bearer': token};
    _socket?.connect();
  }

  void reconnect() {
    disconnect();
    startListen();
  }

  void _onConnectTimeout(data) {
    _socket?.connect();
  }

  void _initSocket(String token) {
    _socket = io.io(
      _baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'authorization': 'Bearer $token'})
          .enableReconnection()
          .enableAutoConnect()
          .build(),
    )
      ..onConnect(_onConnect)
      ..onDisconnect(_onDisconnect)
      ..onConnectTimeout(_onConnectTimeout)
      ..on(ChatSocketEvents.chatNewMassage, _onNewMessage)
      ..on(ChatSocketEvents.deleteMassage, _onRemoveMessage)
      ..on(ChatSocketEvents.error, _onErrorHandler)
      ..onError(_onError);

    _socket!.connect();
  }

  void _onConnect(_) {
    _debug('socket is connected ${_socket!.connected} ${_socket!.id}');
  }

  void _onNewMessage(dynamic data) async {
    final message = GroupMessage.fromJson(data as Map<String, dynamic>);
    _chatBloc?.add(GroupChatEvent.newMessage(message: message));
    _chatBloc?.add(const GroupChatEvent.getUnreadCount());
  }

  void _onRemoveMessage(dynamic data) {
    final removeData = SocketRemoveData.fromJson(data as Map<String, dynamic>);
    _chatBloc?.add(GroupChatEvent.removeMessageFromSocket(fromMessageId: removeData.id));
  }

  void _onErrorHandler(dynamic data) {
    disconnect();
    _debug('on ${SocketEvents.error}: $data');
  }

  void _debug(String data) {
    debugPrint('SocketIO -------: ${DateTime.now().toIso8601String()} on  $data');
  }

  void _onDisconnect(dynamic data) {
    if ((data as String) == 'io server disconnect') {
      reconnect();
    } else {
      _debug('socket is disconnect with reason: $data');
    }
  }

  void _onError(dynamic data) {
    _debug('Error: $data');
  }
}
