import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/preparation_materials.dart';
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
      decoration: BoxDecoration(
        // color: AppColors.bgGreen,

        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(
          width: 1,
          color: AppColors.blueLighter,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 42,
                height: 42.0,
                child: ImageIcon(
                  AppIcons.checkmark,
                  color: AppColors.blueDarker,
                  size: 24.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.w400(
                    '${groupSession.startDate.toLocal().weekdayString} ${groupSession.startDate.toLocal().fullDateWithHyphen}',
                    style: context.textTheme.titleLarge,
                  ),
                  CustomText.w400(
                    LocalizedTexts.fromToLower.tr(
                      namedArgs: {
                        'startTime': groupSession.startDate.toLocal().timeHoursMinutes24,
                        'endTime': groupSession.startDate
                            .toLocal()
                            .add(Duration(seconds: duration))
                            .timeHoursMinutes24,
                      },
                    ),
                    style: context.textTheme.titleLarge,
                  ),
                  CustomText.w400(
                    LocalizedTexts.numberOfAvailableSeats.translateWithNamedArgs({
                      'number': '${groupSession.availableSeatsAmount}',
                      'totalNumber': '${groupSession.maxMemberCount}',
                    }),
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const PreparationMaterials(),
          const SizedBox(height: 16.0),
          CustomOutlinedButton.blue(
            label: LocalizedTexts.cancelBooking.translation,
            onPressed: () => _onCancelPressed(context),
          ),
        ],
      ),
    );
  }

  _onCancelPressed(BuildContext context) {
    context.read<TopicsBloc>().add(TopicsEvent.signOutFromSession(groupSession.id));
  }
}
