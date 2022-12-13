import 'package:injectable/injectable.dart';

@singleton
class AppConfig {
  String get baseUrl =>
      'https://loopcare.app'; // TODO: change when there will be a host
}
