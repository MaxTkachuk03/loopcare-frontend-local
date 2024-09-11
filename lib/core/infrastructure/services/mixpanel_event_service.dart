import 'package:firebase_performance/firebase_performance.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/country_code_service/country_code_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_manager.dart';
import 'package:loopcare_frontend/core/infrastructure/services/stored_account_service/stored_account_service.dart';

class MixpanelEventService {
  static final instance = MixpanelEventService._();
  final mixpanel = MixpanelManager();

  MixpanelEventService._();

  final Map<String, Trace> _traces = {};

  String get userId {
    final accountId = StoredAccountService.getAccount()?.id ?? -1;
    final userIdPrefix = CountryCodeService.instance.serverCountryCode;
    final id = '$accountId-$userIdPrefix';
    return id;
  }

  Future<void> track(String eventName, {Map<String, dynamic>? parameters}) async {
    if (!kIsProd) {
      return;
    }
    Map<String, dynamic> tmpParameters = Map.from(parameters ?? {});
    tmpParameters[AnalyticsParameters.userId] = userId;
    mixpanel.track(eventName, tmpParameters);
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
