import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  Future<String?> getToken() async {
    String? token;

    try {
      token = await FirebaseMessaging.instance.getToken();
    } on Exception catch (_) {
      // ignore
    }

    return token;
  }
}
