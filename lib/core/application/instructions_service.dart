import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

const instructionsUrl = 'https://loopcare-pdf-instructions.s3.eu-central-1.amazonaws.com/Dokument2-2.pdf';

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
