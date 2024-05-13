import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/network_service/network_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/splash_screen/infrastructure/splash_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController _controller;

  Future<void> _initPackageInfo(BuildContext context, AppUpdateState state) async {
    final info = await PackageInfo.fromPlatform();

    if (!context.mounted) return;

    int platformMinVersion = Platform.isAndroid
        ? state.data.androidMinVersion
        : state.data.iosMinVersion;

    if (int.parse(info.buildNumber) < platformMinVersion) {
      ModalBottomSheet.appUpdate(
        context: context,
        onUpdatePressed:() => _launchInBrowser(context),
      );
    } else {
      FlutterNativeSplash.remove();

      final routes = await _controller.getRoute();

      if (context.mounted) {
        context.router.pushAll(routes);
      }
    }
  }

  Future<void> _launchInBrowser(BuildContext context) async {
    String link;
    if (kIsProd) {
      link = Platform.isAndroid ? playStoreAppUrl : appStoreAppUrl;
    } else {
      link = Platform.isAndroid ? firebaseAndroidAppUrl : testFlightAppUrl;
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

  @override
  void initState() {
    super.initState();
    _controller = SplashController(
      appUpdateBloc: context.read<AppUpdateBloc>(),
      authenticationBloc:  context.read<AuthenticationBloc>(),
      legalStatementBloc: context.read<LegalStatementBloc>(),
      onboardingBloc: context.read<GeneralOnboardingBloc>(),
    );

    _controller.requestPermissions();

    final networkStatus = context.read<NetworkStatus>();

    if (networkStatus == NetworkStatus.offline) {
      context.showError(
        content: CustomText(LocalizedTexts.connectionLost.tr()),
      );
    } else {
      _controller.initApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUpdateBloc, AppUpdateState>(
      listener: (context, state) {
        state.mapOrNull(
          loaded: (state) => _initPackageInfo(context, state),
        );
      },
      child: CustomScaffold.green(),
    );
  }
}
