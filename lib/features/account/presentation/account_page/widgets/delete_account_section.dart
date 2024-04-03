import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DeleteAccountSection extends StatefulWidget {
  const DeleteAccountSection({super.key});

  @override
  State<DeleteAccountSection> createState() => _DeleteAccountSectionState();
}

class _DeleteAccountSectionState extends State<DeleteAccountSection> {
  _onDeleteAccountPressed(BuildContext context, bool noActiveSubscription, SubscriptionState state) {
    isVendorPlatform(state)
        ? ModalBottomSheet.deleteAccount(
            context: context,
            noActiveSubscription: noActiveSubscription,
            onDeleted: () {
              context.read<AuthenticationBloc>().add(const AuthenticationEvent.deleteAccount());
              AnalyticsEventService.instance.logEvent(
                FirebaseEvents.deleteAccount,
                parameters: {
                  CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
                  CustomDefinitions.confirmed: true,
                },
              );
            },
            onSubscriptionPref: () => Platform.isIOS
                ? launchUrl(Uri.parse(appConfig.appStoreSettingsLink), mode: LaunchMode.externalApplication)
                : launchUrl(Uri.parse(appConfig.playMarketSettingsLink),
                    mode: LaunchMode.externalApplication),
          )
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
              child: Text(LocalizedTexts.ok.tr().toUpperCase()),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child:
          //Todo hide subscription flow LOOPCARE-2197
          // BlocListener<SubscriptionBloc, SubscriptionState>(
          //   listener: (context, state) => state.maybeMap(
          //     error: (state) => _errorListener,
          //     gotAccountSubscription: (state) => _onDeleteAccountPressed(context, !state.data.hasSubscription, state),
          //     orElse: () => null,
          //   ),
          //   child:
          Column(
        children: [
          CustomOutlinedButton.coralFullWidth(
            onPressed: () =>
                context.read<AuthenticationBloc>().add(const AuthenticationEvent.deleteAccount()),
            //Todo hide subscription flow LOOPCARE-2197
            // context.read<SubscriptionBloc>().add(const SubscriptionEvent.getAccountSubscription()),
            label: LocalizedTexts.deleteAccount.tr(),
          ),
        ],
      ),
      // ),
    );
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
