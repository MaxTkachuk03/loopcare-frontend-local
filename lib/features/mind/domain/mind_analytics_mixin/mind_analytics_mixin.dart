import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';

mixin MindAnalyticsMixin {
  int? _techniqueId;
  int? _exerciseId;

  set techniqueId(int id) => _techniqueId = id;

  set exerciseId(int id) => _exerciseId = id;

  void track(String event) {
    AnalyticsEventService.instance.logEvent(
      event,
      parameters: {
        if (_techniqueId != null ) CustomDefinitions.techniqueId: _techniqueId,
        if (_exerciseId != null ) CustomDefinitions.exerciseId: _exerciseId,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }
}
