part of 'chat_watcher_bloc.dart';

@freezed
class ChatWatcherEvent with _$ChatWatcherEvent {
  const factory ChatWatcherEvent.getNewMassage(int count) = GetNewMassage;

  const factory ChatWatcherEvent.init() = ChatWatcherInit;

  const factory ChatWatcherEvent.unblockGroupChat() = UnblockGroupChat;

  const factory ChatWatcherEvent.blockGroupChat() = BlockGroupChat;
}
