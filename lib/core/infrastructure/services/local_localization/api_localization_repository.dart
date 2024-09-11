import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/local_localization/localization_repository.dart';
import 'package:loopcare_frontend/core/infrastructure/hive_service/hive_constants.dart';

const repoTranslationsKey = 'translations';

@Injectable(as: LocalizationRepository)
class ApiLocalizationRepository implements LocalizationRepository {
  Box<String> get _box => Hive.box(HiveBoxConstants.localization);

  @override
  String? getTranslations() => _box.get(repoTranslationsKey);

  @override
  Future<void> updateTranslations(String translations) async {
    _box.put(repoTranslationsKey, translations);
  }
}
