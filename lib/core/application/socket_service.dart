import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/socket_data.dart';
import 'package:loopcare_frontend/core/application/socket_service_abstract.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

const String kEventSlotCancelled = 'SLOT_CANCELLED';
const String kEventTopicAvailable = 'TOPIC_AVAILABLE';
const String kEventTopicUnavailable = 'TOPIC_UNAVAILABLE';
const String kEventNewTopicAvailable = 'NEW_TOPIC_AVAILABLE';
const String kEventTopicSlotFinished = 'SLOT_FINISHED';
const String kEventTopicSlotStarted = 'SLOT_STARTED';
const String kEventTopicSlotStartedSoon = 'SLOT_STARTING_SOON';

final getIt = GetIt.instance;

AppConfig appConfig = getIt<AppConfig>();

@Injectable(as: SocketService)
class IOSocketService extends SocketService {
  final String _baseUrl = 'wss://${appConfig.baseHost}/group-session';
  final AuthTokenManager _tokenManager = getIt<AuthTokenManager>();
  final TopicsBloc topicsBloc = getIt<TopicsBloc>();
  String? _authToken;
  io.Socket? _socket;

  Future<void> _initToken() async {
    final token = await _tokenManager.getAccessToken();
    if (token != null) {
      _authToken = token;
    }
  }

  /// Should started after login
  @override
  Future<void> startListen() async {
    if (_authToken == null) {
      await _initToken();
    }

    if (_socket == null) {
      _initSocket();
    } else {
      connect();
    }
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

  void connect() {
    _socket?.io.options!['authorization'] = {'Bearer': _authToken};
    _socket?.connect();
  }

  void reconnect() {
    disconnect();
    startListen();
  }

  void _onConnectTimeout(data) {
    _socket?.connect();
  }

  void _initSocket() {
    _socket = io.io(
      _baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'authorization': 'Bearer $_authToken'})
          .enableReconnection()
          .enableAutoConnect()
          .build(),
    )
      ..onConnect((data) => _onConnect())
      ..onDisconnect((data) => _onDisconnect(data))
      ..onConnectTimeout((data) => _onConnectTimeout(data))
      ..on(kEventSlotCancelled, (data) => _onSlotCancelled(data))
      ..on(kEventTopicAvailable, (data) => _onTopicAvailable(data))
      ..on(kEventTopicUnavailable, (data) => _onTopicUnavailable(data))
      ..on(kEventNewTopicAvailable, (data) => _onNewTopicAvailable(data))
      ..on(kEventTopicSlotFinished, (data) => _onTopicSlotFinished(data))
      ..on(kEventTopicSlotStarted, (data) => _onTopicSlotStarted(data))
      ..on(kEventTopicSlotStartedSoon, (data) => _onTopicSlotStartedSoon(data))
      ..onError((data) => _onError(data));

    _socket!.connect();
  }

  void _onConnect() {
    _debug('socket is connected ${_socket!.connected} ${_socket!.id}');
  }

  void refreshTopics() {
    topicsBloc.add(const TopicsEvent.fetchTopics());
    _debug('refreshTopics BLoC event');
  }

  void _onSlotCancelled(dynamic data) {
    refreshTopics();
    _debug('on $kEventSlotCancelled: $data');
  }

  void _onTopicAvailable(dynamic data) {
    refreshTopics();
    _debug('on $kEventTopicAvailable: $data');
  }

  void _onTopicUnavailable(dynamic data) {
    refreshTopics();
    _debug('on $kEventTopicUnavailable: $data');
  }

  void _onNewTopicAvailable(dynamic data) {
    refreshTopics();
    _debug('on $kEventNewTopicAvailable: $data');
  }

  void _onTopicSlotFinished(dynamic data) {
    refreshTopics();
    _debug('on $kEventTopicSlotFinished: $data');
  }

  void _onTopicSlotStarted(dynamic data) {
    refreshTopics();
    _debug('on $kEventTopicSlotStarted: $data');
  }

  void _onTopicSlotStartedSoon(dynamic data) {
    refreshTopics();
    _debug('on $kEventTopicSlotStartedSoon: $data');
  }

  void _debug(String data) {
    if (kDebugMode) {
      print('SocketIO -------: ${DateTime.now().toIso8601String()} on  $data');
    }
  }

  void _onDisconnect(dynamic data) {
    if ((data as String) == 'io server disconnect') {
      connect();
    } else {
      _debug('socket is disconnect with reason: $data');
    }
  }

  void _onError(dynamic data) {
    _debug('Error: $data');
  }
}
