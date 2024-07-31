import 'package:facebook_app_events/facebook_app_events.dart';

class FacebookEventsService {
  static final FacebookAppEvents _service = FacebookAppEvents();

  static void logEvent({required String eventName, Map<String, dynamic>? parameters}) {
    _service.logEvent(name: eventName, parameters: parameters);
  }
}
