import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

part 'chat_watcher_bloc.freezed.dart';
part 'chat_watcher_event.dart';
part 'chat_watcher_state.dart';

@singleton
class ChatWatcherBloc extends Bloc<ChatWatcherEvent, ChatWatcherState> {
  ChatWatcherBloc() : super(const ChatWatcherState.initial(ChatWatcherStateData())) {
    on<ChatWatcherInit>(_onInitChatWatcher);
    on<GetNewMassage>(_onGetNewMassage);
    on<BlockGroupChat>(_onBlockGroupChat);
    on<UnblockGroupChat>(_onUnblockGroupChat);
  }

  FutureOr<void> _onInitChatWatcher(
    ChatWatcherInit event,
    Emitter<ChatWatcherState> emit,
  ) async =>
      emit(const ChatWatcherState.initial(ChatWatcherStateData()));

  FutureOr<void> _onBlockGroupChat(
    BlockGroupChat event,
    Emitter<ChatWatcherState> emit,
  ) async =>
      emit(ChatWatcherState.blockedChat(state.data.copyWith(lockChat: true)));

  FutureOr<void> _onUnblockGroupChat(
    UnblockGroupChat event,
    Emitter<ChatWatcherState> emit,
  ) async =>
      emit(ChatWatcherState.unblockedChat(state.data.copyWith(lockChat: false)));

  FutureOr<void> _onGetNewMassage(
    GetNewMassage event,
    Emitter<ChatWatcherState> emit,
  ) async {
    emit(ChatWatcherState.gotNewMessage(state.data.copyWith(amount: 1)));
  }
}
