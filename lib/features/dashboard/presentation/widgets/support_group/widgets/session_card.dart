import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_signed_might_cancelled.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';

class SessionCard extends StatelessWidget {
  final String topicName;
  final DateTime startDate;
  final DateTime endDate;
  final bool preparationMaterialsAvailable;
  final bool isCancelledOrMissed;
  final bool isCancelled;
  final bool isMissed;
  final bool timeSlotsAvailable;
  final bool sessionMightBeCancelled;
  final bool isHappeningNow;
  final bool isCanJoin;
  final int minMemberCount;
  // final String image;

  const SessionCard({
    super.key,
    required this.topicName,
    required this.startDate,
    required this.endDate,
    required this.preparationMaterialsAvailable,
    required this.isCancelledOrMissed,
    required this.isCancelled,
    required this.isMissed,
    required this.timeSlotsAvailable,
    required this.sessionMightBeCancelled,
    required this.isHappeningNow,
    required this.isCanJoin,
    required this.minMemberCount,
    // required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationProgramBloc, EducationProgramState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => _onBookSeatPressed(context),
          child: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.blueLighter,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 180.0,
                  child: ClipPath(
                    clipper: EducationClipper(),
                    child: const Image(image: AppImages.sessionPlaceholder),
                    // TODO: Need update after all images will be provided
                    // NetworkImageWithCache(
                    //   url: image,
                    // ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: AppColors.coralRegular,
                            borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          ),
                          child: CustomText.w600(
                            topicName.toUpperCase(),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.white,
                              fontSize: ThemeConstants.fontSize10,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        CustomText.w700(
                          topicName,
                          style: context.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 10.0),
                        Wrap(
                          children: [
                            _dateText(context),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        if (preparationMaterialsAvailable && !isCanJoin)
                          CustomOutlinedButton.coral(
                            label: LocalizedTexts.prepareForSession.translation,
                            onPressed: () => _onBookSeatPressed(context),
                          ),
                        if (isCanJoin && !isCancelledOrMissed)
                          CustomOutlinedButton.coral(
                            label: LocalizedTexts.joinSession.translation,
                            onPressed: () => _onJoinPressed(context),
                          ),
                        if (isCancelledOrMissed && timeSlotsAvailable)
                          CustomOutlinedButton.coral(
                            label: LocalizedTexts.chooseAnotherTimeslot.translation,
                            onPressed: () => _onBookSeatPressed(context),
                          ),
                        if (isCancelledOrMissed && !timeSlotsAvailable)
                          CustomText.w400(
                            LocalizedTexts.noTimeslotsOnthisWeek.tr(),
                            style: context.textTheme.bodySmall,
                          ),
                        if (!isCancelled && sessionMightBeCancelled)
                          GroupedSignedMightBeCancelled(number: minMemberCount),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dateText(BuildContext context) {
    if (isHappeningNow && !isCancelledOrMissed) {
      return CustomText.w400(
        LocalizedTexts.dayFromTo.tr(
          namedArgs: {
            'day': '${startDate.weekdayString} ${startDate.shortDate}',
            'startTime': startDate.timeHoursMinutes24,
            'endTime': endDate.timeHoursMinutes24,
          },
        ),
        style: context.textTheme.bodySmall?.copyWith(
          fontSize: ThemeConstants.fontSize12,
        ),
      );
    }
    if (!isHappeningNow) {
      return CustomText.w400(
        LocalizedTexts.bookedFromTo.tr(
          namedArgs: {
            'day': '${startDate.weekdayString} ${startDate.shortDate}',
            'startTime': startDate.timeHoursMinutes24,
            'endTime': endDate.timeHoursMinutes24,
          },
        ),
        style: context.textTheme.bodySmall?.copyWith(
          fontSize: ThemeConstants.fontSize12,
        ),
      );
    }
    if (isCancelledOrMissed) {
      return Row(
        children: [
          const Image(image: AppIcons.exclamationPoint, width: 16, height: 16),
          const SizedBox(width: 8.0),
          if (isCancelled)
            CustomText.w400(
              LocalizedTexts.timeslotCancelled.translation,
              style: context.textTheme.bodySmall?.copyWith(color: AppColors.orangeDark),
            ),
          if (!isCancelled && isMissed)
            CustomText.w400(
              LocalizedTexts.timeslotMissed.translation,
              style: context.textTheme.bodySmall?.copyWith(color: AppColors.orangeDark),
            ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  _onJoinPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.sessionWaitingRoom);
  }

  _onBookSeatPressed(BuildContext context) {
    ModalBottomSheet.sessionsDialog(context: context);
  }
}
