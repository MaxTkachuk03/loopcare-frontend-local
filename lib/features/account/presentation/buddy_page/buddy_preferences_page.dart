import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_status.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_invitation_approved.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_invitation_pedding.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_invitation_reject.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_not_available.dart';

@RoutePage()
class BuddyPreferencesPage extends StatefulWidget {
  const BuddyPreferencesPage({super.key});

  @override
  State<BuddyPreferencesPage> createState() => _BuddyPreferencesPageState();
}

class _BuddyPreferencesPageState extends State<BuddyPreferencesPage> {
  String get _btnLabel {
    final buddyState = context.read<BuddyBloc>().state.data.buddyState;
    return switch (buddyState) {
      BuddyStatus.invited => LocalizedTexts.removeInvite.tr(),
      BuddyStatus.rejected || BuddyStatus.left || BuddyStatus.expired => LocalizedTexts.inviteBuddy.tr(),
      BuddyStatus.approved => LocalizedTexts.removeBuddy.tr(),
      _ => '',
    };
  }

  Function get _btnHandler {
    final buddyState = context.read<BuddyBloc>().state.data.buddyState;
    return switch (buddyState) {
      BuddyStatus.invited || BuddyStatus.approved => _onRemoveInvite,
      BuddyStatus.rejected || BuddyStatus.left || BuddyStatus.expired => _onInviteBuddy,
      _ => () {},
    };
  }

  void _onRemoveInvite() {
    ModalBottomSheet.removeInviteConfirmation(
        context: context, onAnotherBuddy: _onAnotherBuddyHandler);
  }

  void _onAnotherBuddyHandler() {
    context.read<BuddyBloc>().add(const BuddyEvent.removeBuddy());

    context.router.pushAndPopUntil(
      const BuddyIntroRoute(),
      predicate: (Route<dynamic> route) => route.settings.name == HomeRoute.name,
    );
  }

  void _onInviteBuddy() {
    context.read<BuddyBloc>().add(const BuddyEvent.updateBuddyStatus(null));

    context.router.pushAndPopUntil(
      const BuddyIntroRoute(),
      predicate: (Route<dynamic> route) => route.settings.name == HomeRoute.name,
    );
  }

  void _errorListener(BuildContext context, BuddyState state) {
    if (state is BuddyStateError) {
      context.showErrorBar(
        content: CustomText(state.data.errorMessage.tr()),
        position: FlashPosition.top,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      withBg: true,
      appBar: CustomAppBar.blue(
        leading: CustomFilledIconButton.leadingBlueLighter(),
        title: LocalizedTexts.buddyPreferences.tr(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: BlocConsumer<BuddyBloc, BuddyState>(
                    listener: _errorListener,
                    builder: (BuildContext context, BuddyState state) {
                      return state.maybeWhen(
                        loading: (_) => const Loader(),
                        invited: (_) => const BuddyInvitationPending(),
                        rejected: (_) => const BuddyInvitationReject(),
                        approved: (_) => const BuddyInvitationApproved(),
                        left: (_) => const BuddyNotAvailable(),
                        orElse: () => const BuddyNotAvailable(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: CustomElevatedButton.orangeFullWidth(
                    label: _btnLabel,
                    onPressed: () => _btnHandler(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
