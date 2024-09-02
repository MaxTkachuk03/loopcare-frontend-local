import 'dart:io';

import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
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
