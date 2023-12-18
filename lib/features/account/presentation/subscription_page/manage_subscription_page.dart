import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:url_launcher/url_launcher.dart';

AppConfig appConfig = getIt<AppConfig>();

class ManageSubscriptionPage extends StatefulWidget {
  const ManageSubscriptionPage({super.key});

  @override
  State<ManageSubscriptionPage> createState() => _ManageSubscriptionPageState();
}

class _ManageSubscriptionPageState extends State<ManageSubscriptionPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SubscriptionBloc>().add(const SubscriptionEvent.getActiveSubscription());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) => state.maybeMap(
        error: (state) => _errorListener,
        orElse: () => null,
      ),
      builder: (context, state) {
        return Scaffold(
          appBar: BlueAppBar(
            isCustomLeading: true,
            title: LocalizedTexts.manageSubscription.tr(),
          ),
          body: SafeArea(
            child: ScrollableContainer(
              child: MainContainer(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    _DetailsSection(
                      title: LocalizedTexts.subscriptionType,
                      value: state.data.subscription?.subscriptionPlan?.title ?? '',
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    _DetailsSection(
                      title: LocalizedTexts.subscriptionVia,
                      value: state.data.subscription == null
                          ? ''
                          : state.data.subscription!.vendor == 'ios'
                              ? 'App Store'
                              : 'Play Market',
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    _DetailsSection(
                      title: LocalizedTexts.memberSince,
                      value: _getDate(state.data.subscription?.purchasedAt) ?? '',
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    _DetailsSection(
                      title: LocalizedTexts.automaticRenewalOn,
                      value: _getDate(state.data.subscription?.expiresAt) ?? '',
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    _ManageButton(
                      onTap: isVendorPlatform(state)
                          ? () {
                              Platform.isIOS
                                  ? launchUrl(Uri.parse(appConfig.appStoreSettingsLink),
                                      mode: LaunchMode.externalApplication)
                                  : launchUrl(Uri.parse(appConfig.playMarketSettingsLink),
                                      mode: LaunchMode.externalApplication);
                            }
                          : () => _showPopover(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
          content: Text(LocalizedTexts.otherPurchaseVendor.tr()),
          actions: [
            TextButton(
              onPressed: () => context.router.pop(),
              child: Text(LocalizedTexts.ok.toUpperCase()),
            ),
          ],
        ),
      );

  String? _getDate(String? timeStamp) {
    if (timeStamp == null) {
      return null;
    }
    final date = DateFormat('yyyy-MM-ddTHH:mm:sssZ').parseUtc(timeStamp).toLocal();
    return DateFormat('dd MMM yyyy').format(date);
  }

  _errorListener(BuildContext context, SubscriptionState state) {
    final errorMessage = state.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr();
    context.showErrorBar(
      content: Text(errorMessage),
      position: FlashPosition.top,
    );
    context.router.pop();
  }
}

class _DetailsSection extends StatelessWidget {
  final String title;
  final String? value;

  const _DetailsSection({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 109,
      child: Row(
        children: [
          Expanded(
            child: AccountContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: ThemeConstants.fontSize16,
                          fontWeight: FontWeight.w400,
                          fontFamily: ThemeConstants.openSansFontFamily,
                          color: AppColors.darkGreen,
                        ),
                  ).tr(),
                  Text(value ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: ThemeConstants.fontSize18,
                            fontWeight: FontWeight.w600,
                            fontFamily: ThemeConstants.openSansFontFamily,
                            color: AppColors.darkGreen,
                          )).tr(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ManageButton extends StatelessWidget {
  final Function()? onTap;

  const _ManageButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: Theme.of(context)
            .elevatedButtonTheme
            .style
            ?.copyWith(backgroundColor: MaterialStateProperty.all(AppColors.blueAppBar)),
        child: Text(
          LocalizedTexts.manageSubscription,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: ThemeConstants.fontSize16,
                fontFamily: ThemeConstants.openSansFontFamily,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
        ).tr(),
      ),
    );
  }
}
