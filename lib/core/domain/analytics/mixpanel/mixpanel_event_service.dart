import 'package:firebase_performance/firebase_performance.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/mixpanel_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/services/stored_account_service/stored_account_service.dart';

class MixpanelEventService {
  static final instance = MixpanelEventService._();
  final mixpanel = MixpanelManager();

  MixpanelEventService._();

  final Map<String, Trace> _traces = {};

  int get _userId => StoredAccountService.getAccount()?.id ?? -1;

  Future<void> track(String eventName, {Map<String, dynamic>? parameters}) async {
    Map<String, dynamic> tmpParameters = Map.from(parameters ?? {});
    tmpParameters[AnalyticsParameters.userId] = _userId;
    mixpanel.track(eventName, tmpParameters);
    return;
  }

  void reset() => mixpanel.reset();

  void identify({int? id}) => mixpanel.identify(id: id);

  void alias(int id) => mixpanel.alias(id);

  Future<void> stopTrace(String eventName) async {
    if (_traces.containsKey(eventName)) {
      mixpanel.track(eventName, null);
      _traces[eventName]?.stop();
      _traces.remove(eventName);
    }
  }
}
