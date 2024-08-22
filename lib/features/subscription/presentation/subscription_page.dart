import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_status_widget.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late SubscriptionController controller;
  Widget content = const Loader();
  final ValueNotifier<bool> sheetOpenedNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    controller = SubscriptionController(bloc: context.read<SubscriptionBloc>());
    CustomerIoService.track(
      event: CIOEvents.subscriptionPage,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.getSubscriptionPlans();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        withBg: false,
        color: AppColors.blueRegular,
        appBar: CustomAppBar.transparent(
          leading: const SizedBox.shrink(),
          actions: [_LogoutWidget()],
          title: null,
        ),
        body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
          listenWhen: _listenerStates,
          listener: (context, state) => state.maybeWhen(
            successInPlans: (data) => controller.setupPlans(data),
            subscriptionActive: (data) => context.router.replaceNamed(AppRoutes.home),
            purchaseDuplicateSubscription: (data) => _onDuplicateSettings(context),
            purchasedSubscription: (data) => (data.subscription?.isActive ?? false)
                ? _navigateToHome()
                : _onRestoreFromSettings(data),
            askRestoredSubscription: (data) => _showAskRestorePopover(),
            loading: (data) => controller.handleLoading(data.isLoading),
            logout: (_) => context.router.replaceAll([const IntroRoute()]),
            error: (_) => _errorListener(context, state),
            orElse: () => null,
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => content,
            trial: (s) => content = SubscriptionStateView.trial(
              controller: controller,
              topCover: AppImages.subscriptionTop,
              bottomCover: AppColors.blueRegular,
            ),
            trialExpired: (_) => content = SubscriptionStateView.trialExpired(
              controller: controller,
              topCover: AppImages.subscriptionTop,
              bottomCover: AppColors.blueRegular,
            ),
            subscriptionEnded: (_) => content = SubscriptionStateView.endedSubscription(
              controller: controller,
              topCover: AppImages.subscriptionTop,
              bottomCover: AppColors.blueRegular,
            ),
            subscriptionCancelled: (_) => content = SubscriptionStateView.cancelledSubscription(
              controller: controller,
              topCover: AppImages.subscriptionTop,
              bottomCover: AppColors.blueRegular,
            ),
            subscriptionUnRenewed: (_) => content = SubscriptionStateView.notRenewSubscription(
              controller: controller,
              onTap: () => context.router.replaceNamed(AppRoutes.home),
              topCover: AppImages.subscriptionTop,
              bottomCover: AppColors.blueRegular,
            ),
            serviceSubscriptionUnavailable: (_) =>
                content = SubscriptionStateView.serviceUnavailable(
              controller: controller,
              topCover: AppImages.subscriptionTop,
              bottomCover: AppColors.blueRegular,
            ),
          ),
        ),
      ),
    );
  }

  void _onDuplicateSettings(BuildContext context) {
    if (!sheetOpenedNotifier.value) {
      sheetOpenedNotifier.value = true;
      controller.handleLoading(false);
      _showRestoreSubscriptionBottomSheet(isDuplicate: true);
    }
  }

  void _onRestoreFromSettings(SubscriptionStateData data) {
    if (!sheetOpenedNotifier.value) {
      sheetOpenedNotifier.value = true;
      controller.handleLoading(false);
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
      sheetNotifier: sheetOpenedNotifier,
      onSubscriptionPref: () {
        launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
        context.read<SubscriptionBloc>().add(const SubscriptionEvent.logout());
      },
    );
  }

  bool isVendorPlatform(String? vendor) =>
      Platform.isIOS && vendor == 'ios' || Platform.isAndroid && vendor == 'android';

  void _showPopover() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: CustomText(LocalizedTexts.otherPurchaseVendorCancelAccountSubscription.tr()),
          actions: [
            TextButton(
              onPressed: context.router.maybePop,
              child: Text(LocalizedTexts.ok.tr().toUpperCase()),
            ),
          ],
        ),
      );

  void _showAskRestorePopover() {
    controller.loading.value = false;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: CustomText(LocalizedTexts.askRestoreSubscription.tr()),
        actions: [
          TextButton(
            onPressed: context.router.maybePop,
            child: Text(LocalizedTexts.ok.tr().toUpperCase()),
          ),
        ],
      ),
    );
  }

  bool _listenerStates(prev, cur) =>
      cur is ErrorSubscriptionState ||
      cur is SuccessSubscriptionPlans ||
      cur is PurchasedSubscriptionState ||
      cur is SubscriptionActual ||
      cur is LoadingSubscriptionState ||
      cur is PurchasedDuplicateSubscriptionState ||
      cur is AskRestoredSubscriptionState ||
      cur is LogoutState;

  void _errorListener(BuildContext context, SubscriptionState state) {

    controller.resetState();
    context.showErrorBar(
      content: CustomText(state.data.errorKey.tr()),
      position: FlashPosition.top,
    );
  }

  void _navigateToHome() {
    PageRouteInfo path = const HomeRoute();
    if (!context.read<RiverBloc>().state.data.isBeginningComplete) {
      path = const RiverOverviewRoute();
    }

    context.router.replaceAll([path]);
  }
}

class _LogoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.blueLight,
        child: IconButton(
          icon: const Icon(
            Icons.logout,
            color: AppColors.blueDarkest,
          ),
          onPressed: () => context.read<SubscriptionBloc>().add(const SubscriptionEvent.logout()),
        ),
      ),
    );
  }
}
