import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_sync_event.freezed.dart';

@freezed
class AppSyncEvent with _$AppSyncEvent {
  const AppSyncEvent._();

  const factory AppSyncEvent.refreshTopics() = _RefreshTopics;

  const factory AppSyncEvent.buddyRejectInvite() = _BuddyRejectInvite;

  const factory AppSyncEvent.buddyLeft() = _BuddyLeft;

  const factory AppSyncEvent.buddyAcceptedInvite() = _BuddyAcceptedInvite;

  const factory AppSyncEvent.refreshChatMessages() = _RefreshChatMessages;
}