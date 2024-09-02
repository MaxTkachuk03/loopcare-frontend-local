import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/domain/grouped_session_widget_state.dart';

class SessionCardButton extends StatelessWidget {
  final GroupedSessionWidgetState sessionWidgetState;

  const SessionCardButton({super.key, required this.sessionWidgetState});

  void _onJoinPressed(BuildContext context) =>
      context.router.pushNamed(AppRoutes.sessionWaitingRoom);

  void _onBookSeatPressed(BuildContext context) =>
      ModalBottomSheet.sessionsDialog(context: context);

  @override
  Widget build(BuildContext context) {
    return switch (sessionWidgetState) {
      GroupedSessionWidgetState.notSignedHasSlots => CustomOutlinedButton.coralSmall(
          label: LocalizedTexts.bookYourSeat.tr(),
          onPressed: () => _onBookSeatPressed(context),
        ),
      GroupedSessionWidgetState.signedSessionNotStarted ||
      GroupedSessionWidgetState.signedMinUsersNotReached =>
        CustomOutlinedButton.coralSmall(
          label: LocalizedTexts.prepareForSession.tr(),
          onPressed: () => _onBookSeatPressed(context),
        ),
      GroupedSessionWidgetState.signedSessionInProgress => CustomOutlinedButton.coralSmall(
          label: LocalizedTexts.joinSession.tr(),
          onPressed: () => _onJoinPressed(context),
        ),
      GroupedSessionWidgetState.signedSessionCanceledHasOtherSlots =>
        CustomOutlinedButton.coralSmall(
          label: LocalizedTexts.chooseAlternative.tr(),
          onPressed: () => _onBookSeatPressed(context),
        ),
      GroupedSessionWidgetState.signedSessionCanceledNoOtherSlots => CustomText.w400(
          LocalizedTexts.noAlternativesAvailable.tr(),
          style: context.textTheme.bodySmall,
        ),
      _ => const SizedBox.shrink()
    };
  }
}
