import 'package:firebase_performance/firebase_performance.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_manager.dart';

class MixpanelEventService {
  static final instance = MixpanelEventService._();
  final mixpanel = MixpanelManager();

  MixpanelEventService._();

  final Map<String, Trace> _traces = {};

  Future<void> track(String eventName, Map<String, dynamic> data) async {
    mixpanel.track(eventName, data);
    return;
  }

  Future<void> trackUserEvent(String eventName, int userId, Map<String, dynamic> data) async {
    data.addAll({
      'userId': userId,
    });

    mixpanel.track(eventName, data);

    return;
  }

  Future<void> trackVisit(String eventName, {int userId = -1}) async {
    mixpanel.track(
      eventName,
      {
        'userId': userId,
      },
    );

    return;
  }

  Future<void> stopTrace(String eventName) async {
    if (_traces.containsKey(eventName)) {
      mixpanel.track(eventName, null);
      _traces[eventName]?.stop();
      _traces.remove(eventName);
    }
  }
}
