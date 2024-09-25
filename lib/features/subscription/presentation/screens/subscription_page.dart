import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/presentation/controller/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/presentation/screens/subscription_nonrenewable_page.dart';
import 'package:loopcare_frontend/features/subscription/presentation/screens/subscription_service_unavailable_page.dart';
import 'package:loopcare_frontend/features/subscription/presentation/screens/subscription_single_plan_page.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late SubscriptionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SubscriptionController(bloc: context.read<SubscriptionBloc>());
    CustomerIoService.track(
      event: CIOEvents.subscriptionPage,
    );

    MixpanelEventService.instance.track(
      AppMixpanelEvents.openSubscriptionScreen,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.checkSubscriptionEligible();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Loader();
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: _logoutListener,
      child: CustomSafeArea(
        child: CustomScaffold(
          color: AppColors.blueDarker,
          appBar: CustomAppBar.transparent(
            leading: const SizedBox.shrink(),
            actions: [_LogoutWidget()],
            title: null,
          ),
          body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
            listener: (context, state) => state.maybeWhen(
              setEligibility: (data) => _controller.getSubscriptionPlansFromServer(),
              successInPlans: (data) => _controller.setupPlans(data),
              subscriptionActive: (data) => context.router.replaceNamed(AppRoutes.home),
              purchaseDuplicateSubscription: (data) => _onDuplicateSettings(context),
              purchasedSubscription: (data) => (data.subscription?.isActive ?? false)
                  ? _navigateToHome()
                  : _onRestoreFromSettings(data),
              askRestoredSubscription: (data) => _showAskRestorePopover(),
              loading: (data) => _controller.handleLoading(data.isLoading),
              error: (_) => _errorListener(context, state),
              orElse: () => null,
            ),
            builder: (context, state) => state.maybeWhen(
              orElse: () => content,
              singlePlan: (_) => content = SubscriptionSinglePlanPage(
                controller: _controller,
              ),
              subscriptionUnRenewed: (_) => content = const SubscriptionNonrenewablePage(),
              serviceSubscriptionUnavailable: (_) =>
                  content = const SubscriptionServiceUnavailablePage(),
            ),
          ),
        ),
      ),
    );
  }

  void _onDuplicateSettings(BuildContext context) {
    if (!_controller.sheetOpenedNotifier.value) {
      _controller.sheetOpenedNotifier.value = true;
      _controller.handleLoading(false);
      _showRestoreSubscriptionBottomSheet(isDuplicate: true);
    }
  }

  void _onRestoreFromSettings(SubscriptionStateData data) {
    if (!_controller.sheetOpenedNotifier.value) {
      _controller.sheetOpenedNotifier.value = true;
      _controller.handleLoading(false);
      if (isVendorPlatform(data.subscription?.vendor)) {
        _showRestoreSubscriptionBottomSheet();
      } else {
        _showPopover();
      }
    }
  }

  void _showRestoreSubscriptionBottomSheet({bool isDuplicate = false}) {
    final link = Platform.isIOS ? appStoreSettingsLink : playMarketSettingsLink;

    ModalBottomSheet.restoreSubscription(
      context: context,
      isDuplicate: isDuplicate,
      sheetNotifier: _controller.sheetOpenedNotifier,
      onSubscriptionPref: () {
        launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
        context.read<SubscriptionBloc>().add(const SubscriptionEvent.logout());
        context.read<AuthenticationBloc>().add(const AuthenticationEvent.logout());
      },
    );
  }

  bool isVendorPlatform(String? vendor) =>
      Platform.isIOS && vendor == 'ios' || Platform.isAndroid && vendor == 'android';

  void _showPopover() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: CustomText(
            LocalizedTexts.subscriptionOtherPurchaseVendorCancelAccountSubscription.tr(),
          ),
          actions: [
            TextButton(
              onPressed: context.router.maybePop,
              child: Text(LocalizedTexts.ok.tr().toUpperCase()),
            ),
          ],
        ),
      );

  void _showAskRestorePopover() {
    _controller.loading.value = false;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: CustomText(LocalizedTexts.subscriptionAskRestoreSubscription.tr()),
        actions: [
          TextButton(
            onPressed: context.router.maybePop,
            child: Text(LocalizedTexts.ok.tr().toUpperCase()),
          ),
        ],
      ),
    );
  }

  void _errorListener(BuildContext context, SubscriptionState state) {
    _controller.handleLoading(state.data.isLoading);
    context.showErrorBar(
        content: CustomText(state.data.errorKey.tr()),
        position: FlashPosition.top,
        duration: const Duration(seconds: 5));
  }

  void _navigateToHome() {
    PageRouteInfo path = const HomeRoute();
    if (!context.read<RiverBloc>().state.data.isBeginningComplete) {
      path = const RiverOverviewRoute();
    }

    context.router.replaceAll([path]);
  }

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}

class _LogoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.blueLighter,
        child: IconButton(
            icon: const Icon(
              Icons.logout,
              color: AppColors.blueDarkest,
            ),
            onPressed: () {
              context.read<SubscriptionBloc>().add(const SubscriptionEvent.logout());
              context.read<AuthenticationBloc>().add(const AuthenticationEvent.logout());
            }),
      ),
    );
  }
}
