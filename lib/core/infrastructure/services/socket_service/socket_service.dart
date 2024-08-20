import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_sync_service/app_sync_service.dart';
// ignore: unused_import
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/infrastructure/services/socket_service/events.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

const _serverDisconnect = 'io server disconnect';

class SocketService {
  final AppConfig? _appConfig;
  final AppSyncService _syncService;
  final AuthTokenManager? _tokenManager;

  String? _baseUrl;
  io.Socket? _socket;
  static final SocketService _instance = SocketService._internal();

  static SocketService get instance => _instance;

  SocketService._internal()
      : _appConfig = GetIt.instance<AppConfig>(),
        _tokenManager = GetIt.instance<AuthTokenManager>(),
        _syncService = GetIt.instance<AppSyncService>() {
    _baseUrl = 'wss://${_appConfig?.baseHost}/buddy';
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
    _socket?.io.options!['authorization'] = token;
    _socket?.connect();
  }

  void reconnect() {
    disconnect();
    startListen();
  }

  void _initSocket(String token) {
    _socket = io.io(
      _baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'authorization': token})
          .enableReconnection()
          .enableAutoConnect()
          .build(),
    )
      ..onConnect(_onConnect)
      ..onDisconnect(_onDisconnect)
      ..onConnectTimeout(_onConnectTimeout)
      ..on(SocketEvents.slotCancelled, _refreshTopics)
      ..on(SocketEvents.topicAvailable, _refreshTopics)
      ..on(SocketEvents.topicUnavailable, _refreshTopics)
      ..on(SocketEvents.newTopicAvailable, _refreshTopics)
      ..on(SocketEvents.topicSlotFinished, _refreshTopics)
      ..on(SocketEvents.topicSlotStarted, _refreshTopics)
      ..on(SocketEvents.topicSlotStartedSoon, _refreshTopics)
      ..on(SocketEvents.buddyInvited, _onBuddyInvited)
      ..on(SocketEvents.buddyRejectInvite, _onBuddyRejectInvite)
      ..on(SocketEvents.buddyLeft, _onBuddyLeft)
      ..on(SocketEvents.buddyAcceptedInvite, _onBuddyAcceptedInvite)
      ..on(SocketEvents.error, _onErrorHandler)
      ..onError(_onError);

    _socket!.connect();
  }

  void _onConnect(_) {
    _debug('Socket is connected: ${_socket!.connected}, ${_socket!.id}');
  }

  void _onConnectTimeout(data) {
    _socket?.connect();
  }

  void _onDisconnect(dynamic data) {
    if ((data as String) == _serverDisconnect) {
      reconnect();
    } else {
      _debug('Socket is disconnect with reason: $data');
    }
  }

  void _onErrorHandler(dynamic data) {
    disconnect();
    _debug('on ${SocketEvents.error}: $data');
  }

  void _onError(dynamic data) {
    _debug('Socket Error: $data');
  }

  void _refreshTopics(dynamic data) => _syncService.refreshTopics();

  void _onBuddyInvited(dynamic data) => _syncService.buddyInvited();

  void _onBuddyRejectInvite(dynamic data) => _syncService.buddyRejectInvite();

  void _onBuddyLeft(dynamic data) => _syncService.buddyLeft();

  void _onBuddyAcceptedInvite(dynamic data) => _syncService.buddyAcceptedInvite();

  void _debug(String data) {
    // log.i(data, error: 'SocketIO');
  }
}
