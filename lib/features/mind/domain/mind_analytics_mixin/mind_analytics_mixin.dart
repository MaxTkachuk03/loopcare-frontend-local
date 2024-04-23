import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';

mixin MindAnalyticsMixin {
  int? get techniqueId => null;
  int? get exerciseId => null;

  void track(String event, {bool forCIO = true}) {
    AnalyticsEventService.instance.logEvent(
      event,
      parameters: {
        if (techniqueId != null ) CustomDefinitions.techniqueId: techniqueId,
        if (exerciseId != null ) CustomDefinitions.exerciseId: exerciseId,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );

    if (forCIO) {
      CustomerIoService.track(
        event: event,
        attributes: {
          if (techniqueId != null ) CIOAttributes.techniqueId: techniqueId,
          if (exerciseId != null ) CIOAttributes.exerciseId: exerciseId,
        },
      );
    }
  }
}
