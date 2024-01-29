import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/support_group/widgets/grouped_signed_might_cancelled.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';

class SessionCard extends StatelessWidget {
  final String topicName;
  final DateTime startDate;
  final DateTime endDate;
  final bool preparationMaterialsAvailable;
  final bool isCancelledOrMissed;
  final bool isCancelled;
  final bool isMissed;
  final String image;
  final bool isFinished;
  final bool timeSlotsAvailable;
  final bool sessionMightBeCancelled;
  final bool isHappeningNow;
  final bool isCanJoin;
  final int minMemberCount;

  const SessionCard({
    super.key,
    required this.topicName,
    required this.startDate,
    required this.endDate,
    required this.preparationMaterialsAvailable,
    required this.isCancelledOrMissed,
    required this.isCancelled,
    required this.isMissed,
    required this.isFinished,
    required this.timeSlotsAvailable,
    required this.sessionMightBeCancelled,
    required this.isHappeningNow,
    required this.isCanJoin,
    required this.minMemberCount,
    required this.image,
  });

  String? _categoryLabel() {
    if (isCancelled) return LocalizedTexts.cancelled.translation;
    if (isMissed) return LocalizedTexts.missed.translation;
    if (sessionMightBeCancelled) return LocalizedTexts.minimumNotReached.translation;
    if (isFinished) return LocalizedTexts.completed.translation;

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationProgramBloc, EducationProgramState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => _onBookSeatPressed(context),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.blueLighter, style: BorderStyle.solid),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Row(
                  children: [
                    ClipPath(
                      clipper: EducationClipper(),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: SizedBox(
                          width: 135,
                          height: 180,
                          child: NetworkImageWithCache(url: image),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            if (_categoryLabel() != null)
                              CategoryLabel(label: _categoryLabel() ?? '', color: AppColors.coralRegular),
                            const SizedBox(height: 10.0),
                            CustomText.w700(
                              topicName,
                              style: context.textTheme.bodySmall,
                            ),
                            const SizedBox(height: 10.0),
                            _dateText(context),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isCancelledOrMissed && !timeSlotsAvailable)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomText.w400(
                    LocalizedTexts.noTimeslotsOnThisWeek.tr(),
                    style: context.textTheme.bodySmall,
                  ),
                ),
              if (!isCancelled && sessionMightBeCancelled)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GroupedSignedMightBeCancelled(number: minMemberCount),
                ),
              if (isCancelledOrMissed)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      if (isCancelled)
                        CustomText.w400(
                          LocalizedTexts.timeslotCancelled.translation,
                          style: context.textTheme.bodySmall?.copyWith(color: AppColors.orangeRegular),
                        ),
                      if (!isCancelled && isMissed)
                        CustomText.w400(
                          LocalizedTexts.timeslotMissed.translation,
                          style: context.textTheme.bodySmall?.copyWith(color: AppColors.orangeRegular),
                        ),
                    ],
                  ),
                ),
            ],
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

    return const SizedBox.shrink();
  }

  _onJoinPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.sessionWaitingRoom);
  }

  _onBookSeatPressed(BuildContext context) {
    ModalBottomSheet.sessionsDialog(context: context);
  }
}
