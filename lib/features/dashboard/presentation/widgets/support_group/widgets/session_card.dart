import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/domain/grouped_session_widget_state.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/session_card_button.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

class SessionCard extends StatelessWidget {
  final GroupedSessionWidgetState sessionWidgetState;

  const SessionCard({super.key, required this.sessionWidgetState});

  Widget get _label => switch (sessionWidgetState) {
        GroupedSessionWidgetState.signedMinUsersNotReached => CategoryLabel(
            label: LocalizedTexts.minimumNotReached.tr(), color: AppColors.coralRegular),
        GroupedSessionWidgetState.signedSessionCanceledNoOtherSlots ||
        GroupedSessionWidgetState.signedSessionCanceledHasOtherSlots =>
          CategoryLabel(label: LocalizedTexts.cancelled.tr(), color: AppColors.coralRegular),
        GroupedSessionWidgetState.signedSessionCompleted =>
          CategoryLabel(label: LocalizedTexts.completed.tr(), color: AppColors.coralRegular),
        _ => const SizedBox.shrink(),
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicsBloc, TopicsState>(builder: (BuildContext context, TopicsState state) {
      final topic = state.data.weekTopic;

      if (topic == null) return const SizedBox.shrink();

      final startDate = state.data.signedGroupSession?.localStartTime;
      final endDate = state.data.signedGroupSession?.localEndTime;

      final day = '${startDate?.toDateFormat}';
      final startTime = '${startDate?.toTimeFormat}';
      final endTime = '${endDate?.toTimeFormat}';

      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.blueLighter, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          children: [
            ClipPath(
              clipper: ImageClipper(),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                child: SizedBox(
                    width: 135, height: 220, child: NetworkImageWithCache(url: topic.image)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    _label,
                    const SizedBox(height: 10.0),
                    CustomText.bitter700(
                      state.data.weekTopicName,
                      style: context.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10.0),
                    if (state.data.isSigned)
                      CustomText.w400(
                        LocalizedTexts.dayFromTo.tr( {
                          'day': day,
                          'startTime': startTime,
                          'endTime': endTime,
                        },),
                        style: context.textTheme.bodySmall,
                      ),
                    const SizedBox(height: 10.0),
                    SessionCardButton(sessionWidgetState: sessionWidgetState),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
