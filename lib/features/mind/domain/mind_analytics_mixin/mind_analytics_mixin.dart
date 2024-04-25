import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';

mixin MindAnalyticsMixin {
  int? _techniqueId;
  int? _exerciseId;

  set techniqueId(int id) => _techniqueId == id;

  set exerciseId(int id) => _exerciseId == id;

  void track(String event, {bool forCIO = true}) {
    AnalyticsEventService.instance.logEvent(
      event,
      parameters: {
        if (_techniqueId != null ) CustomDefinitions.techniqueId: _techniqueId,
        if (_exerciseId != null ) CustomDefinitions.exerciseId: _exerciseId,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );

    if (forCIO) {
      CustomerIoService.track(
        event: event,
        attributes: {
          if (_techniqueId != null ) CIOAttributes.techniqueId: _techniqueId,
          if (_exerciseId != null ) CIOAttributes.exerciseId: _exerciseId,
        },
      );
    }
  }
}
