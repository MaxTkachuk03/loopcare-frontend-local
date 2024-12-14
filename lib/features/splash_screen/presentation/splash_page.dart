import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/splash_screen/infrastructure/splash_controller.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController _controller;

  Future<void> _initPackageInfo(AppUpdateState state) async {
    if (state.data.needToForceUpdate) {
      FlutterNativeSplash.remove();
      AppUpdateBottomSheet.showAppUpdate();
    } else if (_controller.isAuthorized) {
      _controller.getAccount();
    } else {
      _navigateUnauthorized();
    }

    if (state.data.needToMinorUpdate) {
      Future.delayed(const Duration(seconds: 3), AppUpdateBottomSheet.showMinorAppUpdate);
    }
  }

  void _errorListener(String errorKey) {
    FlutterNativeSplash.remove();
    context.showError(content: CustomText(errorKey.tr()));
    _navigateToIntro();
  }

  void _updatePolicies() {
    AppUpdateBottomSheet.showPoliciesUpdate(
      updatePrivacyPolicy: _controller.needUpdatePrivacyPolicy,
      updateTermsAndConditions: _controller.needUpdateTermsAndConditions,
      onConfirmed: _controller.updatePolicy,
    );
  }

  void _onAuthorized() => _controller.getRiverModules();

  Future<void> _navigateAuthorized() async {
    _controller.setUpBottomNavigationBar();
    final routes = await _controller.getRoute();

    if (!mounted) return;
    context.router.replaceAll(routes);

    FlutterNativeSplash.remove();
  }

  void _navigateUnauthorized() {
    final routes = _controller.getOnboardingRoute();
    FlutterNativeSplash.remove();
    context.router.replaceAll(routes);
  }

  void _navigateToIntro() => context.router.replaceNamed(AppRoutes.intro);

  @override
  void initState() {
    super.initState();
    _controller = SplashController(
      appUpdateBloc: context.read<AppUpdateBloc>(),
      authenticationBloc: context.read<AuthenticationBloc>(),
      legalStatementBloc: context.read<LegalStatementBloc>(),
      onboardingBloc: context.read<GeneralOnboardingBloc>(),
      riverBloc: context.read<RiverBloc>(),
      navigationBarBloc: context.read<NavigationBarBloc>(),
    );

    _controller.requestPermissions();
    _controller.initApp();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppUpdateBloc, AppUpdateState>(
          listener: (context, state) => state.mapOrNull(
            loaded: _initPackageInfo,
            error: (state) => _errorListener(state.data.error?.message ?? ''),
          ),
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) => state.mapOrNull(
            needUpdatePolicies: (_) => _updatePolicies(),
            gotAccount: (_) => _onAuthorized(),
            error: (state) => _errorListener(state.data.error?.message ?? ''),
          ),
        ),
        BlocListener<RiverBloc, RiverState>(
          listener: (context, state) => state.mapOrNull(
            moduleLoaded: (_) => _navigateAuthorized(),
            moduleLoadingError: (state) => _errorListener(state.data.error?.message ?? ''),
          ),
        ),
      ],
      child: CustomScaffold.blueLightest(),
    );
  }
}
