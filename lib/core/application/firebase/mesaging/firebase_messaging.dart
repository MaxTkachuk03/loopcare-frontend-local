import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    String? token;

    bool guard = true;

    if (Platform.isAndroid) {
      final settings = await _firebaseMessaging.requestPermission(announcement: true);
      guard = settings.authorizationStatus == AuthorizationStatus.authorized;
    }

    if (guard) {
      token = await _getToken();
    }

    return token;
  }

  Future<String?> _getToken() async {
    String? token;
    try {
      token = await _firebaseMessaging.getToken();
    } on Exception catch (_) {
      // ignore
    }

    return token;
  }
}