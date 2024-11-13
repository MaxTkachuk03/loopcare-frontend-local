import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/url_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class DeleteAccountSection extends StatefulWidget {
  const DeleteAccountSection({super.key});

  @override
  State<DeleteAccountSection> createState() => _DeleteAccountSectionState();
}

class _DeleteAccountSectionState extends State<DeleteAccountSection> {
  void launchSubscriptionPref() {
    final link = Platform.isIOS ? appStoreSettingsLink : playMarketSettingsLink;

    launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
  }

  _onDeleteAccountPressed(
    BuildContext context,
    bool noActiveSubscription,
    SubscriptionState state,
  ) =>
      isVendorPlatform(state)
          ? ModalBottomSheet.deleteAccount(
              context: context,
              noActiveSubscription: noActiveSubscription,
              onDeleted: () {
                context.read<AuthenticationBloc>().add(const AuthenticationEvent.deleteAccount());
                const AnalyticsEventService().logEvent(
                  eventName: AnalyticsEvents.deleteAccount,
                  parameters: {
                    AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
                    AnalyticsParameters.confirmed: true,
                  },
                );
              },
              onSubscriptionPref: launchSubscriptionPref,
            )
          : _showPopover();

  bool isVendorPlatform(SubscriptionState state) =>
      Platform.isIOS && (state.data.subscription?.vendor == 'ios') ||
      Platform.isAndroid && (state.data.subscription?.vendor == 'android');

  void _showPopover() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: CustomText(
              LocalizedTexts.subscriptionOtherPurchaseVendorCancelAccountSubscription.tr()),
          actions: [
            TextButton(
              onPressed: () => context.router.maybePop(),
              child: Text(LocalizedTexts.ok.tr().toUpperCase()),
            ),
          ],
        ),
      );

  void _confirmDelete() => ModalBottomSheet.deleteAccount(
        context: context,
        noActiveSubscription: true,
        onDeleted: () {
          context.read<AuthenticationBloc>().add(const AuthenticationEvent.deleteAccount());
          const AnalyticsEventService().logEvent(
            eventName: AnalyticsEvents.deleteAccount,
            parameters: {
              AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
              AnalyticsParameters.confirmed: 'true',
            },
          );
        },
        onSubscriptionPref: () {},
      );

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: BlocListener<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) => state.maybeMap(
          error: (state) => _errorListener,
          gotAccountSubscription: (state) =>
              _onDeleteAccountPressed(context, !state.data.hasSubscription, state),
          orElse: () => null,
        ),
        child: Column(
          children: [
            CustomOutlinedButton.coralFullWidth(
              onPressed: () => kIsProd
                  ? context
                      .read<SubscriptionBloc>()
                      .add(const SubscriptionEvent.getAccountSubscription())
                  : _confirmDelete(),
              label: LocalizedTexts.deleteAccount.tr(),
            ),
          ],
        ),
      ),
    );
  }

  _errorListener(BuildContext context, SubscriptionState state) {
    final errorMessage = state.data.errorKey;
    context.showErrorBar(
      content: Text(errorMessage.tr()),
      position: FlashPosition.top,
    );
    context.router.maybePop();
  }
}
