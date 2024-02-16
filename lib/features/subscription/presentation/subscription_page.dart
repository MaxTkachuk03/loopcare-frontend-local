import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_controller.dart';
import 'package:loopcare_frontend/features/subscription/presentation/widget/subscription_status_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late SubscriptionController controller;
  Widget content = const Loader();

  @override
  void initState() {
    super.initState();
    controller = SubscriptionController(bloc: context.read<SubscriptionBloc>());
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
      child: CustomScaffold.yellow(
        appBar: CustomAppBar.transparent(
          leading: const SizedBox.shrink(),
          actions: [_LogoutWidget()],
          title: null,
        ),
        body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
          listenWhen: _listenerStates,
          listener: (BuildContext context, SubscriptionState state) => state.maybeWhen(
            successInPlans: (data) => controller.setupPlans(data),
            subscriptionActive: (data) => context.router.replaceNamed(AppRoutes.home),
            purchasedSubscription: (data) => (data.subscription?.isActive ?? false)
                ? context.router.replaceNamed(AppRoutes.home)
                : _onRestoreFromSettings(context, state),
            loading: (data) => controller.handleLoading(data.isLoading),
            logout: (_) => context.router.replaceAll([const IntroRoute()]),
            error: (_) => _errorListener(context, state),
            orElse: () => null,
          ),
          builder: (BuildContext context, SubscriptionState state) => state.maybeWhen(
            orElse: () => content,
            trial: (s) => content = SubscriptionStateView.trial(
              controller: controller,
              topCover: AppImages.trial,
              bottomCover: AppColors.coralRegular,
            ),
            trialExpired: (_) => content = SubscriptionStateView.trialExpired(
              controller: controller,
              topCover: AppImages.ended,
              bottomCover: AppColors.petrolRegular,
            ),
            subscriptionEnded: (_) => content = SubscriptionStateView.endedSubscription(
              controller: controller,
              topCover: AppImages.ended,
              bottomCover: AppColors.petrolRegular,
            ),
            subscriptionCancelled: (_) => content = SubscriptionStateView.cancelledSubscription(
              controller: controller,
              topCover: AppImages.ended,
              bottomCover: AppColors.petrolRegular,
            ),
            subscriptionUnRenewed: (_) => content = SubscriptionStateView.notRenewSubscription(
              controller: controller,
              onTap: () => context.router.replaceNamed(AppRoutes.home),
              topCover: AppImages.ended,
              bottomCover: AppColors.petrolRegular,
            ),
            serviceSubscriptionUnavailable: (_) => content = SubscriptionStateView.serviceUnavailable(
              controller: controller,
              topCover: AppImages.ended,
              bottomCover: AppColors.petrolRegular,
            ),
          ),
        ),
      ),
    );
  }

  _onRestoreFromSettings(BuildContext context, SubscriptionState state) {
    isVendorPlatform(state)
        ? ModalBottomSheet.restoreSubscription(
            context: context,
            onSubscriptionPref: Platform.isIOS
                ? () {
                    launchUrl(Uri.parse(appConfig.appStoreSettingsLink), mode: LaunchMode.externalApplication);
                    context.read<SubscriptionBloc>().add(const SubscriptionEvent.logout());
                  }
                : () {
                    launchUrl(Uri.parse(appConfig.playMarketSettingsLink), mode: LaunchMode.externalApplication);
                    context.read<SubscriptionBloc>().add(const SubscriptionEvent.logout());
                  })
        : _showPopover();
  }

  bool isVendorPlatform(SubscriptionState state) {
    if (Platform.isIOS && (state.data.subscription?.vendor == 'ios') ||
        Platform.isAndroid && (state.data.subscription?.vendor == 'android')) {
      return true;
    }
    return false;
  }

  void _showPopover() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: CustomText(LocalizedTexts.otherPurchaseVendorCancelAccountSubscription.tr()),
          actions: [
            TextButton(
              onPressed: () => context.router.pop(),
              child: Text(LocalizedTexts.ok.toUpperCase()),
            ),
          ],
        ),
      );

  bool _listenerStates(prev, cur) =>
      cur is ErrorSubscriptionState ||
      cur is SuccessSubscriptionPlans ||
      cur is PurchasedSubscriptionState ||
      cur is SubscriptionActual ||
      cur is LoadingSubscriptionState ||
      cur is LogoutState;

  _errorListener(BuildContext context, SubscriptionState state) {
    final errorMessage = state.data.error?.error ?? LocalizedTexts.somethingWentWrong.tr();
    controller.resetState();
    context.showErrorBar(
      content: Text(errorMessage),
      position: FlashPosition.top,
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
        backgroundColor: AppColors.yellowLighter,
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
