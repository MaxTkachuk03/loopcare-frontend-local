import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bottom_sheet.dart';
import 'package:loopcare_frontend/core/infrastructure/services/network_service/network_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/splash_screen/infrastructure/splash_controller.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController _controller;

  Future<void> _initPackageInfo(AppUpdateState state) async {
    FlutterNativeSplash.remove();

    if (state.data.needToUpdate) {
      AppUpdateBottomSheet.showAppUpdate();
    } else if (_controller.isAuthorized) {
      _controller.getAccount();
    } else {
      _navigateUnauthorized();
    }
  }

  void _appUpdateErrorListener(AppUpdateState state) {
    FlutterNativeSplash.remove();
    _errorListener(state.data.error?.error);
  }

  void _errorListener(dynamic error) {
    _navigateToIntro();
    context.showError(content: CustomText(error?.toString() ?? LocalizedTexts.somethingWentWrong.tr()));
  }

  void _updatePolicies() {
    AppUpdateBottomSheet.showPoliciesUpdate(
      updatePrivacyPolicy: _controller.needUpdatePrivacyPolicy,
      updateTermsAndConditions: _controller.needUpdateTermsAndConditions,
      onConfirmed: _controller.updatePolicy,
    );
  }

  void _onAuthorized() {
    context.read<RiverBloc>().add(const RiverEvent.getModules());
  }

  Future<void> _navigateAuthorized() async {
    _controller.setUpBottomNavigationBar();
    final routes = await _controller.getRoute();

    if (context.mounted) {
      // ignore: use_build_context_synchronously
      context.router.replaceAll(routes);
    }
  }

  void _navigateUnauthorized() {
    final routes = _controller.getOnboardingRoute();
    context.router.replaceAll(routes);
  }

  void _navigateToIntro() => context.router.replaceNamed(AppRoutes.intro);

  @override
  void initState() {
    super.initState();
    _controller = SplashController(
      appUpdateBloc: context.read<AppUpdateBloc>(),
      authenticationBloc:  context.read<AuthenticationBloc>(),
      legalStatementBloc: context.read<LegalStatementBloc>(),
      onboardingBloc: context.read<GeneralOnboardingBloc>(),
      riverBloc: context.read<RiverBloc>(),
      navigationBarBloc: context.read<NavigationBarBloc>(),
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AppUpdateBloc, AppUpdateState>(
          listener: (context, state) => state.mapOrNull(
              loaded: _initPackageInfo,
              error: _appUpdateErrorListener,
            ),
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) => state.mapOrNull(
              needUpdatePolicies: (_) => _updatePolicies(),
              gotAccount: (_) => _onAuthorized(),
              error: (state) => _errorListener(state.data.error?.error),
            ),
        ),
        BlocListener<RiverBloc, RiverState>(
          listener: (context, state) => state.mapOrNull(
            moduleLoaded: (_) => _navigateAuthorized(),
          ),
        ),
      ],
      child: CustomScaffold.blueLightest(),
    );
  }
}
