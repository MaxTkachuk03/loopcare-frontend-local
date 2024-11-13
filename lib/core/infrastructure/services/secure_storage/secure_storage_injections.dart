import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/secure_storage/secure_storage_service.dart';

@module
abstract class SecureStorageServiceDi {
  @lazySingleton
  Future<SecureStorageService> get sharedService => SecureStorageService().init();
}
