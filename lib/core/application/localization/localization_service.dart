import 'package:loopcare_frontend/core/domain/local_localization/local_localization_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalizationService {
  Future<bool> loadLocalLocalizations() async {
    String locale = getIt<AppConfig>().language;
    final jsonString = await rootBundle.loadString('lib/l10n/app_$locale.arb');
    getIt<LocalLocalizationService>().translations = jsonString;
    return true;
  }
}
