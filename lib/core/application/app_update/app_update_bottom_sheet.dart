import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateBottomSheet {

  static String get _storeLink {
    if (kIsProd) {
      return Platform.isAndroid ? playStoreAppUrl : appStoreAppUrl;
    } else {
      return Platform.isAndroid ? firebaseAndroidAppUrl : testFlightAppUrl;
    }
  }

  static void show() {
    ModalBottomSheet.appUpdate(
      context: kOverlayContext,
      onUpdatePressed: _launchInBrowser
    );
  }

  static Future<void> _launchInBrowser() async {
    final uri = Uri.parse(_storeLink);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      _showError();
    }
  }

  static void _showError() =>
      kOverlayContext.showError(content: CustomText(LocalizedTexts.openLinkErrorMessage.tr()));
}
