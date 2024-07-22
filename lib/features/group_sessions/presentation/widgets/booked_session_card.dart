import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class BookedSessionCard extends StatelessWidget {
  final GroupSession groupSession;
  final int duration;

  const BookedSessionCard({
    super.key,
    required this.groupSession,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppColors.blueLightest,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 42.0,
                height: 42.0,
                child: ImageIcon(
                  AppIcons.checkmark,
                  color: AppColors.greenRegular,
                  size: 24.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.w600(
                    '${groupSession.startDate.toLocal().weekdayString} ${groupSession.startDate.toLocal().fullDateWithHyphen}',
                    style: context.textTheme.titleMedium,
                  ),
                  CustomText.w600(
                    LocalizedTexts.fromToLower.tr(
                      namedArgs: {
                        'startTime': groupSession.startDate.toLocal().timeHoursMinutes24,
                        'endTime': groupSession.startDate
                            .toLocal()
                            .add(Duration(seconds: duration))
                            .timeHoursMinutes24,
                      },
                    ),
                    style: context.textTheme.titleMedium,
                  ),
                  CustomText.w400(
                    LocalizedTexts.numberOfAvailableSeats.tr(
                      namedArgs: {
                        'number': '${groupSession.availableSeatsAmount}',
                        'totalNumber': '${groupSession.maxMemberCount}',
                      },
                    ),
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          CustomElevatedButton.blueFullWidth(
            onPressed: () => _onPrepareInfoPressed(context),
            label: LocalizedTexts.prepareTakes.tr(
              namedArgs: {'times': '10'},
            ),
          ),
          const SizedBox(height: 16.0),
          CustomOutlinedButton.coralFullWidth(
            label: LocalizedTexts.cancelBooking.tr(),
            onPressed: () => _onCancelPressed(context),
          ),
        ],
      ),
    );
  }

  _onPrepareInfoPressed(BuildContext context) {
    final sessionId = context.read<TopicsBloc>().state.data.signedGroupSessionId ?? 0;

    context.read<AnalyticsBloc>().add(
          AnalyticsEvent.sendAnalytics(
            AnalyticsEvents.openedSessionPreparationMaterials,
            {
              AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
            },
          ),
        );

  AnalyticsEventService().openedSessionPreparationMaterialsEvent(
      sessionId,
      groupSession.topic,
    );

    context.router.pushNamed(AppRoutes.preparationMaterials);
  }

  _onCancelPressed(BuildContext context) {
    AnalyticsEventService().logEvent( eventName:
    AnalyticsEvents.userSignedOutFromSession,
      parameters: {
        AnalyticsParameters.sessionId: groupSession.id.toString(),
      },
    );
    context.read<TopicsBloc>().add(TopicsEvent.signOutFromSession(groupSession.id));
  }
}
