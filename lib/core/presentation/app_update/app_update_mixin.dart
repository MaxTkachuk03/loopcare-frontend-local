import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

mixin AppUpdateMixin {
  Future<void> initPackageInfo(BuildContext context) async {
    final info = await PackageInfo.fromPlatform();

    if (!context.mounted) return;

    int platformMinVersion = Platform.isAndroid
        ? context.read<AppUpdateBloc>().state.data.androidMinVersion
        : context.read<AppUpdateBloc>().state.data.iosMinVersion;

    if (int.parse(info.buildNumber) < platformMinVersion) {
      ModalBottomSheet.appUpdate(
        context: context,
        onUpdatePressed:() => _launchInBrowser(context),
      );
    }
  }


  Future<void> _launchInBrowser(BuildContext context) async {
    String link;
    if (const String.fromEnvironment('FLAVOR') == 'prod') {
      link = Platform.isAndroid ? playStoreAppUrl : appStoreAppUrl;
    } else {
      link = Platform.isAndroid ? firebaseAndroidAppUrl : firebaseIosAppUrl;
    }

    final uri = Uri.parse(link);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        _showError(context);
      }
    }
  }

  void _showError(BuildContext context) =>
      context.showError(content: CustomText(LocalizedTexts.openLinkErrorMessage.tr()));
}