import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/domain/grouped_session_widget_state.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/session_card.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class Grouped extends StatelessWidget {
  const Grouped({super.key});

  GroupedSessionWidgetState _getWidgetState(BuildContext context) {
    final state = context.read<TopicsBloc>().state.data;

    if (state.isNotSignedHasFreeTimeSlots) {
      return GroupedSessionWidgetState.notSignedHasSlots;
    }

    if (state.isNotSignedHasNoFreeTimeSlots) {
      return GroupedSessionWidgetState.notSignedNoSlots;
    }

    if (state.isNotSignedNoSessions) {
      return GroupedSessionWidgetState.notSignedNoSessions;
    }

    if (state.signedMinUsersNotReached) {
      return GroupedSessionWidgetState.signedMinUsersNotReached;
    }

    if (state.signedSessionCanceledHasOtherSlots) {
      return GroupedSessionWidgetState.signedSessionCanceledHasOtherSlots;
    }

    if (state.signedSessionCanceledNoOtherSlots) {
      return GroupedSessionWidgetState.signedSessionCanceledNoOtherSlots;
    }

    if (state.signedSessionInProgress) {
      return GroupedSessionWidgetState.signedSessionInProgress;
    }

    if (state.signedSessionNotStarted) {
      return GroupedSessionWidgetState.signedSessionNotStarted;
    }

    if (state.signedSessionCompleted) {
      return GroupedSessionWidgetState.signedSessionCompleted;
    }

    return GroupedSessionWidgetState.signedSessionNotStarted;
  }

  Widget _getAdditionalTextWidget(BuildContext context, GroupedSessionWidgetState state) =>
      switch (state) {
        GroupedSessionWidgetState.signedSessionCanceledNoOtherSlots => CustomText.w400(
            LocalizedTexts.noOtherTimeslotsAvailable.tr(),
            style: context.textTheme.bodySmall,
          ),
        GroupedSessionWidgetState.signedSessionCompleted => CustomText.w400(
            LocalizedTexts.nextWeekTopic.tr(),
            style: context.textTheme.bodyMedium,
          ),
        _ => const SizedBox.shrink(),
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsBloc, TopicsState>(
      builder: (context, state) {
        final sessionWidgetState = _getWidgetState(context);

        return state.maybeMap(
          error: (errorState) {
            final error = errorState.data.error;

            return Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: ErrorScreen(
                error: error!,
                onButtonPressed: () =>
                    context.read<TopicsBloc>().add(const TopicsEvent.fetchTopics()),
              ),
            );
          },
          loading: (_) => const SizedBox(height: 100, child: Loader()),
          orElse: () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.bitter600(
                  state.data.signedSessionInProgress
                      ? LocalizedTexts.happeningNow.tr()
                      : LocalizedTexts.comingUpThisWeek.tr(),
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 16.0),
                switch (sessionWidgetState) {
                  GroupedSessionWidgetState.notSignedNoSlots => CustomText.w400(
                      LocalizedTexts.noOtherTimeslotsAvailable.tr(),
                      style: context.textTheme.bodySmall,
                    ),
                  GroupedSessionWidgetState.notSignedNoSessions => CustomText.w400(
                      LocalizedTexts.noGroupThisWeek.tr(),
                      style: context.textTheme.bodySmall,
                    ),
                  _ => SessionCard(sessionWidgetState: sessionWidgetState),
                },
                const SizedBox(height: 16.0),
                _getAdditionalTextWidget(context, sessionWidgetState),
              ],
            );
          },
        );
      },
    );
  }
}
