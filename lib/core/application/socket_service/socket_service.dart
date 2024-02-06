import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/socket_service/events.dart';
import 'package:loopcare_frontend/core/application/socket_service/socket_data.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  final AppConfig? _appConfig;
  final TopicsBloc? _topicsBloc;
  final AuthTokenManager? _tokenManager;

  String? _baseUrl;
  io.Socket? _socket;
  static final SocketService _instance = SocketService._internal();

  static SocketService get instance => _instance;

  SocketService._internal()
      : _appConfig = GetIt.instance<AppConfig>(),
        _tokenManager = GetIt.instance<AuthTokenManager>(),
        _topicsBloc = GetIt.instance<TopicsBloc>() {
    _baseUrl = 'wss://${_appConfig?.baseHost}/group-session';
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

  void sendData(SocketData data) {
    // Example how to send data to server
    // var data = const SocketData(qwerty: '12345');
    // _socket?.emit(kEventTest1, data.toJson());
  }

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
      ..on(SocketEvents.slotCancelled, _onSlotCancelled)
      ..on(SocketEvents.topicAvailable, _onTopicAvailable)
      ..on(SocketEvents.topicUnavailable, _onTopicUnavailable)
      ..on(SocketEvents.newTopicAvailable, _onNewTopicAvailable)
      ..on(SocketEvents.topicSlotFinished, _onTopicSlotFinished)
      ..on(SocketEvents.topicSlotStarted, _onTopicSlotStarted)
      ..on(SocketEvents.topicSlotStartedSoon, _onTopicSlotStartedSoon)
      ..on(SocketEvents.error, _onErrorHandler)
      ..onError(_onError);

    _socket!.connect();
  }

  void _onConnect(_) {
    _debug('socket is connected ${_socket!.connected} ${_socket!.id}');
  }

  void refreshTopics() {
    _topicsBloc?.add(const TopicsEvent.fetchTopics());
    _debug('refreshTopics BLoC event');
  }

  void _onSlotCancelled(dynamic data) {
    refreshTopics();
    _debug('on ${SocketEvents.slotCancelled}: $data');
  }

  void _onTopicAvailable(dynamic data) {
    refreshTopics();
    _debug('on ${SocketEvents.topicAvailable}: $data');
  }

  void _onTopicUnavailable(dynamic data) {
    refreshTopics();
    _debug('on ${SocketEvents.topicUnavailable}: $data');
  }

  void _onNewTopicAvailable(dynamic data) {
    refreshTopics();
    _debug('on ${SocketEvents.newTopicAvailable}: $data');
  }

  void _onTopicSlotFinished(dynamic data) {
    refreshTopics();
    _debug('on ${SocketEvents.topicSlotFinished}: $data');
  }

  void _onTopicSlotStarted(dynamic data) {
    refreshTopics();
    _debug('on ${SocketEvents.topicSlotStarted}: $data');
  }

  void _onTopicSlotStartedSoon(dynamic data) {
    refreshTopics();
    _debug('on ${SocketEvents.topicSlotStartedSoon}: $data');
  }

  void _onErrorHandler(dynamic data) {
    disconnect();
    _debug('on ${SocketEvents.error}: $data');
  }

  void _debug(String data) {
    debugPrint('devcpp SocketIO -------: ${DateTime.now().toIso8601String()} on  $data');
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
