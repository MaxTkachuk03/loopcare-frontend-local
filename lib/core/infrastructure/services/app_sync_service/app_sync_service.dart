import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_sync_service/app_sync_event.dart';

@singleton
class AppSyncService {
  final StreamController<AppSyncEvent> _streamController =
      StreamController<AppSyncEvent>.broadcast();

  Stream<AppSyncEvent> get stream => _streamController.stream;

  void refreshTopics() => _streamController.add(const AppSyncEvent.refreshTopics());

  void buddyInvited() => _streamController.add(const AppSyncEvent.refreshAccount());

  void disownBuddy() => _streamController
    ..add(const AppSyncEvent.refreshActualRiverModule())
    ..add(const AppSyncEvent.refreshAccount());

  void buddyRejectInvite() => _streamController
    ..add(const AppSyncEvent.showProfileNotificationBadge())
    ..add(const AppSyncEvent.refreshAccount());

  void buddyLeft() => _streamController
    ..add(const AppSyncEvent.refreshActualRiverModule())
    ..add(const AppSyncEvent.showProfileNotificationBadge())
    ..add(const AppSyncEvent.refreshAccount());

  void buddyAcceptedInvite() => _streamController
    ..add(const AppSyncEvent.refreshActualRiverModule())
    ..add(const AppSyncEvent.showProfileNotificationBadge())
    ..add(const AppSyncEvent.refreshAccount());

  void buddyInvitationExpired() => _streamController
    ..add(const AppSyncEvent.refreshActualRiverModule())
    ..add(const AppSyncEvent.showProfileNotificationBadge())
    ..add(const AppSyncEvent.refreshAccount());

  void refreshChatMessages() => _streamController.add(const AppSyncEvent.refreshChatMessages());

  void showProfileNotificationBadge() =>
      _streamController.add(const AppSyncEvent.showProfileNotificationBadge());
}
