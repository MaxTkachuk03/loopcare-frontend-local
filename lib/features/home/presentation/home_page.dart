import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/app_navigation_bar.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> isChatEnable = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    isChatEnable.value = getIt<SharedStorageService>().account?.isUserGrouped ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPackageInfo();
    });
  }

  @override
  void dispose() {
    isChatEnable.dispose();
    super.dispose();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    if (!mounted) return;

    int platformMinVersion = Platform.isAndroid
        ? context.read<AppUpdateBloc>().state.data.androidMinVersion
        : context.read<AppUpdateBloc>().state.data.iosMinVersion;

    if (int.parse(info.buildNumber) < platformMinVersion) {
      ModalBottomSheet.appUpdate(context: context, onUpdatePressed: launchInBrowser);
    }
  }

  void _showError() => context.showError(content: CustomText(LocalizedTexts.openLinkErrorMessage.tr()));

  Future<void> launchInBrowser() async {
    final Uri launchUri = Uri.parse(Platform.isAndroid ? playStoreAppUrl : appStoreAppUrl);

    try {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      _showError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: _logoutListener,
      buildWhen: (context, state) => isChatEnable.value != state.data.isUserGrouped,
      builder: (context, state) {
        _chatEnable(state);
        return AutoTabsScaffold(
          animationDuration: Duration.zero,
          routes: const [
            DashboardRoute(),
            EducationRoute(),
            GroupChatRoute(),
            AccountRoute(),
          ],
          appBarBuilder: (_, tabsRouter) => AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            toolbarHeight: 0.0,
            backgroundColor: DashboardNavbarItems.getColorByIndex(tabsRouter.activeIndex),
          ),
          bottomNavigationBuilder: (_, tabsRouter) => AppNavigationBar(
            tabsRouter: tabsRouter,
            isChatEnable: isChatEnable,
          ),
        );
      },
    );
  }

  void _chatEnable(AuthenticationState state) => isChatEnable.value = state.data.isUserGrouped;

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}
