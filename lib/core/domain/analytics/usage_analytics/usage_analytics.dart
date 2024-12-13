<<<<<<< HEAD
import 'package:loopcare_frontend/core/domain/analytics/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/mixpanel_manager.dart';

enum AnalyticsTarget { customerIO, mixpanel }

class UsageAnalytics {
  // Singleton pattern
  static final UsageAnalytics _instance = UsageAnalytics._internal();
  factory UsageAnalytics() => _instance;
  UsageAnalytics._internal();
  final mixpanel = MixpanelManager();

  /// Track an event with optional parameters and selected targets
  void track({
    required String eventName,
    Map<String, dynamic>? attributes,
    List<AnalyticsTarget> targets = const [
      AnalyticsTarget.customerIO,
      AnalyticsTarget.mixpanel,
    ],
  }) {
    if (targets.contains(AnalyticsTarget.customerIO)) {
      _trackCustomerIO(eventName, attributes);
    }
    if (targets.contains(AnalyticsTarget.mixpanel)) {
      _trackMixpanel(eventName, attributes);
    }
  }

  void _trackCustomerIO(String eventName, Map<String, dynamic>? attributes) {
    CustomerIoService.track(event: eventName, attributes: attributes ?? {});
  }

  void _trackMixpanel(String eventName, Map<String, dynamic>? attributes) {
    mixpanel.track(eventName, attributes);
  }
}
=======
import 'package:loopcare_frontend/core/domain/analytics/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/mixpanel_manager.dart';

enum AnalyticsTarget { customerIO, mixpanel }

class UsageAnalytics {
  // Singleton pattern
  static final UsageAnalytics _instance = UsageAnalytics._internal();
  factory UsageAnalytics() => _instance;
  UsageAnalytics._internal();
  final mixpanel = MixpanelManager();

  /// Track an event with optional parameters and selected targets
  void track({
    required String eventName,
    Map<String, dynamic>? attributes,
    List<AnalyticsTarget> targets = const [
      AnalyticsTarget.customerIO,
      AnalyticsTarget.mixpanel,
    ],
  }) {
    if (targets.contains(AnalyticsTarget.customerIO)) {
      _trackCustomerIO(eventName, attributes);
    }
    if (targets.contains(AnalyticsTarget.mixpanel)) {
      _trackMixpanel(eventName, attributes);
    }
  }

  void _trackCustomerIO(String eventName, Map<String, dynamic>? attributes) {
    CustomerIoService.track(event: eventName, attributes: attributes ?? {});
  }

  void _trackMixpanel(String eventName, Map<String, dynamic>? attributes) {
    mixpanel.track(eventName, attributes);
  }
}
>>>>>>> feature-interactive-lessons
