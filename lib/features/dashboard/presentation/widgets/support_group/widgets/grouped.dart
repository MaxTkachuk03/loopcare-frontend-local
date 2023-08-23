import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/appliction/topics_bloc.dart';

class Grouped extends StatelessWidget {
  final bool nextWeek;

  const Grouped({
    Key? key,
    this.nextWeek = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var groupingStartedAt = DateTime.now();

    return BlocBuilder<TopicsBloc, TopicsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nextWeek
                  ? LocalizedTexts.comingUpNextWeek.tr().toUpperCase()
                  : LocalizedTexts.comingUpThisWeek.tr().toUpperCase(),
              style: const TextStyle(
                fontSize: ThemeConstants.fontSize12,
                color: AppColors.greyLabel,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    state.nextWeekTopicName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ).tr(),
                ),
                const ImageIcon(
                  AppIcons.arrow,
                  color: AppColors.greyLabel,
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              '${LocalizedTexts.booked.translation} ${groupingStartedAt.weekdayString} ' +
                  '${LocalizedTexts.from.translation} ${groupingStartedAt.timeHoursMinutes24} ' +
                  '${LocalizedTexts.to.translation} ${groupingStartedAt.timeHoursMinutes24}.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 8.0,
            ),
            InkWell(
              onTap: () => _onBookSeatPressed(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.blueDark,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocalizedTexts.bookYourSeatNow,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ).tr(),
                    const ImageIcon(
                      AppIcons.arrow,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  _onBookSeatPressed(BuildContext context) {}
}
