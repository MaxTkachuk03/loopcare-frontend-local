import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/firebase/mesaging/firebase_messaging.dart';

@module
abstract class FirebaseMessagingServiceDi {
  @lazySingleton
  FirebaseMessagingService get sharedService => FirebaseMessagingService();
}
