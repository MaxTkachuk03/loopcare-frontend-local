import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';


@module
abstract class SharedPreferencesDi {
  @lazySingleton
  Future<SharedStorageService> get sharedService => SharedStorageService().init();
}
