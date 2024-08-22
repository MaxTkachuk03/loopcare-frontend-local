import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_sync_event.freezed.dart';

@freezed
class AppSyncEvent with _$AppSyncEvent {
  const AppSyncEvent._();

  const factory AppSyncEvent.refreshTopics() = _RefreshTopicsSyncEvent;

  const factory AppSyncEvent.refreshChatMessages() = _RefreshChatMessagesSyncEvent;

  const factory AppSyncEvent.refreshAccount() = _RefreshAccountSyncEvent;

  const factory AppSyncEvent.refreshActualRiverModule() = _RefreshActualRiverModuleSyncEvent;

  const factory AppSyncEvent.showProfileNotificationBadge() = _ShowProfileNotificationSyncEvent;
}
