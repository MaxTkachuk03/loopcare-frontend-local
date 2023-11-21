import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/network_service/network_service.dart';

@module
abstract class NetworkStatusDi {
  @lazySingleton
  NetworkStatusService get connectionService => NetworkStatusService();
}
