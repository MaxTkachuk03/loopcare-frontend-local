import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/local_localization/localization_repository.dart';

@lazySingleton
class LocalLocalizationService {
  final LocalizationRepository _repository;

  LocalLocalizationService(this._repository);

  String? get translations => _repository.getTranslations();

  set translations(String? translations) => _repository.updateTranslations(translations ?? '');
}
