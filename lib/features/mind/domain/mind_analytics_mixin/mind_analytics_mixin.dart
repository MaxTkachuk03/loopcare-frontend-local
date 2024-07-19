import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';

mixin MindAnalyticsMixin {
  int? _techniqueId;
  int? _exerciseId;

  set techniqueId(int id) => _techniqueId = id;

  set exerciseId(int id) => _exerciseId = id;

  void track(String event) {
    AnalyticsEventService().logEvent(
      eventName: event,
      parameters: {
        if (_techniqueId != null) AnalyticsParameters.techniqueId: _techniqueId,
        if (_exerciseId != null) AnalyticsParameters.exerciseId: _exerciseId,
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }
}
