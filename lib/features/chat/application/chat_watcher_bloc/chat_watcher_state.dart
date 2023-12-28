part of 'chat_watcher_bloc.dart';

@freezed
class ChatWatcherState with _$ChatWatcherState {
  const factory ChatWatcherState.initial(ChatWatcherStateData data) = _Initial;

  const factory ChatWatcherState.gotNewMessage(ChatWatcherStateData data) = _GotMessage;

  const factory ChatWatcherState.unblockedChat(ChatWatcherStateData data) = _UnblockedChat;

  const factory ChatWatcherState.blockedChat(ChatWatcherStateData data) = _BlockedChat;

  const factory ChatWatcherState.error(ChatWatcherStateData data) = _Error;
}

@freezed
class ChatWatcherStateData with _$ChatWatcherStateData {
  const ChatWatcherStateData._();

  const factory ChatWatcherStateData({
    RequestError? error,
    @Default(3) int amount,
    @Default(true) lockChat,
  }) = _ChatWatcherStateData;
}
