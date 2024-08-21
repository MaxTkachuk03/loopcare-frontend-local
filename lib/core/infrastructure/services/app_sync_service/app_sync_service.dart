import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_sync_service/app_sync_event.dart';

@singleton
class AppSyncService {
  final StreamController<AppSyncEvent> _streamController =
      StreamController<AppSyncEvent>.broadcast();

  Stream<AppSyncEvent> get stream => _streamController.stream;

  void refreshTopics() => _streamController.add(const AppSyncEvent.refreshTopics());

  void buddyInvited() => _streamController.add(const AppSyncEvent.buddyInvited());

  void buddyRejectInvite() => _streamController.add(const AppSyncEvent.buddyRejectInvite());

  void buddyLeft() => _streamController.add(const AppSyncEvent.buddyLeft());

  void buddyAcceptedInvite() => _streamController.add(const AppSyncEvent.buddyAcceptedInvite());

  void refreshChatMessages() => _streamController.add(const AppSyncEvent.refreshChatMessages());
}
