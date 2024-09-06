abstract class LocalizationRepository {
  String? getTranslations();

  Future<void> updateTranslations(String data);
}
