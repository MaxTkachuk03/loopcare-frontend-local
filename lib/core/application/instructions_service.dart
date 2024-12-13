import 'dart:io';

import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class InstructionsService {
  InstructionsService._();

  static downloadInstructions({required Function onErrorCb}) async {
    try {
      await launchUrl(
        Uri.parse(LocalizedTexts.linksInstructionsUrl.tr()),
        mode: Platform.isIOS ? LaunchMode.platformDefault : LaunchMode.externalApplication,
      );
    } catch (e) {
      onErrorCb();
    }
  }
}
