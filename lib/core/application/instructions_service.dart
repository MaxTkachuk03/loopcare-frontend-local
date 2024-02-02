import 'dart:io';

import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class InstructionsService {
  InstructionsService._();

  static downloadInstructions({required Function onErrorCb}) async {
    try {
      await launchUrl(
        Uri.parse(instructionsUrl),
        mode: Platform.isIOS ? LaunchMode.platformDefault : LaunchMode.externalApplication,
      );
    } catch (e) {
      onErrorCb();
    }
  }
}
