import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_invitation_approved.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_invitation_pedding.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_invitation_reject.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_not_available.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/profile_buddy_no_state.dart';

import '../../../../core/presentation/loader/loader.dart';

class BuddyPreferencesPage extends StatefulWidget {
  const BuddyPreferencesPage({super.key});

  @override
  State<BuddyPreferencesPage> createState() => _BuddyPreferencesPageState();
}

class _BuddyPreferencesPageState extends State<BuddyPreferencesPage> {
  @override
  void didChangeDependencies() {
    context.read<BuddyBloc>().add(const BuddyEvent.getStatusBuddy());
  }

  void _navigateRejectNotAvailableState({bool notAvailable = false}) {
    if (notAvailable) {
      context.read<BuddyBloc>().add(const BuddyEvent.getStatusBuddy(needNavigate: true));
      return;
    }
    context.read<BuddyBloc>().add(const BuddyEvent.removeBuddy());
  }

  void _navigatePendingAcceptedState(BuildContext context) => ModalBottomSheet.inviteNewBuddy(
        context: context,
        onInvite: () => _navigateRejectNotAvailableState(),
      );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<BuddyBloc, BuddyState>(
      listener: (context, state) => state.maybeMap(
        error: (state) => _errorListener,
        removedBuddy: (state) => context.router.pushNamed(AppRoutes.buddyLiveTogether),
        orElse: () => null,
      ),
      builder: (context, state) {
        return CustomScaffold.blue(
          withBg: true,
          appBar: CustomAppBar.blue(
            leading: CustomFilledIconButton.leadingBlueLighter(),
            title: LocalizedTexts.buddyPreferences.tr(),
          ),
          body: SizedBox(
            width: width,
            child: Stack(
              children: [
                CustomSafeArea(
                  child: ScrollableContainer(
                    child: MainContainer(
                      child: state.maybeWhen(
                        orElse: () {
                          Widget content = const SizedBox.shrink();
                          if (state.data.isInvitationApproved) {
                            content = const BuddyInvitationApproved();
                          } else if (state.data.isInvitationPending) {
                            content = const BuddyInvitationPending();
                          } else if (state.data.isInvitationRejected) {
                            content = const BuddyInvitationReject();
                          } else if (state.data.isBuddyNotAvailable) {
                            content = const BuddyNotAvailable();
                          } else if (!state.data.isLoading) {
                            content = const ProfileNoBuddyState();
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 40),
                                  content,
                                  const SizedBox(height: 40),
                                ],
                              ),
                              if (state.data.showInviteAnotherBuddy)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: CustomElevatedButton.coralFullWidth(
                                    label: LocalizedTexts.buddyInviteAnotherBuddy.tr(),
                                    onPressed: state.data.navigateInviteAnotherBuddy
                                        ? () => _navigateRejectNotAvailableState.call(
                                            notAvailable: state.data.isBuddyNotAvailable)
                                        : () => _navigatePendingAcceptedState.call(context),
                                  ),
                                )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: state.data.isLoading ? const Loader() : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _errorListener(BuildContext context, BuddyState state) {
    final errorMessage = state.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr();
    context.showErrorBar(
      content: Text(errorMessage),
      position: FlashPosition.top,
    );
    context.router.pop();
  }
}
