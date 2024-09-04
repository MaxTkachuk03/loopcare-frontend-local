abstract class LocalizationRepository {
  bool hasTranslations();

  String? getTranslations();

  Future<void> updateTranslations(String data);
}
