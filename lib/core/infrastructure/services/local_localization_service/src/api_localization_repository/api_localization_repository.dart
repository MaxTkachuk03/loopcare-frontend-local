import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/hive_service/hive_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/local_localization_service/src/api_localization_repository/localization_adapter.dart';
import 'package:loopcare_frontend/core/infrastructure/services/local_localization_service/src/contracts/localization_repository.dart';
 const repoTranslationsKey = 'translations';

@Injectable(as: LocalizationRepository)
class ApiLocalizationRepository implements LocalizationRepository {
  Box<String> get _box => Hive.box(HiveBoxConstants.localization);

  @PostConstruct()
  void init() {
    Hive.registerAdapter(LocalizationAdapter());
  }

  @override
  bool hasTranslations() => _box.containsKey(repoTranslationsKey);

  @override
  String? getTranslations() => _box.get(repoTranslationsKey);

  @override
  Future<void> updateTranslations(String translations) async {
    _box.put(repoTranslationsKey, translations);
  }
}
