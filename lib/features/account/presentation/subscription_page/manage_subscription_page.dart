import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/subscription/infrastructure/subscription_service.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ManageSubscriptionPage extends StatefulWidget {
  const ManageSubscriptionPage({super.key});

  @override
  State<ManageSubscriptionPage> createState() => _ManageSubscriptionPageState();
}

class _ManageSubscriptionPageState extends State<ManageSubscriptionPage> {
  final AppSubscriptionService inAppPurchaseService = getIt<AppSubscriptionService>();

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
        return CustomScaffold.blue(
          withBg: true,
          appBar: CustomAppBar.blue(
            leading: CustomFilledIconButton.leadingBlueLighter(),
            title: LocalizedTexts.subscriptionManageSubscription.tr(),
          ),
          body: CustomSafeArea(
            child: Column(
              children: [
                Expanded(
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
                            title: LocalizedTexts.subscriptionSubscriptionVia,
                            value: state.data.subscription == null
                                ? ''
                                : state.data.subscription!.vendor == 'ios'
                                    ? LocalizedTexts.subscriptionAppStore
                                    : LocalizedTexts.subscriptionGoogleMarket,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          _DetailsSection(
                            title: LocalizedTexts.subscriptionMemberSince,
                            value: _getDate(state.data.subscription?.purchasedAt) ?? '',
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          _DetailsSection(
                            title: LocalizedTexts.subscriptionAutomaticRenewalOn,
                            value: _getDate(state.data.subscription?.expiresAt) ?? '',
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CustomElevatedButton.coralFullWidth(
                    onPressed: isVendorPlatform(state)
                        ? () {
                            Platform.isIOS
                                ? launchUrl(Uri.parse(appStoreSettingsLink),
                                    mode: LaunchMode.externalApplication)
                                : launchUrl(Uri.parse(playMarketSettingsLink),
                                    mode: LaunchMode.externalApplication);
                          }
                        : () => _showPopover(),
                    label: LocalizedTexts.subscriptionManageSubscription.tr(),
                  ),
                ),
              ],
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
          content: CustomText(LocalizedTexts.subscriptionOtherPurchaseVendor.tr()),
          actions: [
            TextButton(
              onPressed: () => context.router.maybePop(),
              child: Text(LocalizedTexts.ok.tr().toUpperCase()),
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
    final errorMessage = state.data.errorKey;
    context.showErrorBar(
      content: CustomText(errorMessage.tr()),
      position: FlashPosition.top,
    );
    context.router.maybePop();
  }
}

class _DetailsSection extends StatelessWidget {
  final String title;
  final String? value;

  const _DetailsSection({required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 109,
      child: Row(
        children: [
          Expanded(
            child: AccountContainer(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title.tr(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.blueDarker,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  CustomText.w600(
                    value?.tr() ?? '',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: ThemeConstants.fontSize14,
                      color: AppColors.blueDarker,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
