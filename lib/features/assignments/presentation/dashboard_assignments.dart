import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/domain/dashboard_utils.dart';
// import 'package:loopcare_frontend/features/mood/domain/mood.dart';
// import 'package:loopcare_frontend/features/mood/infrastructure/mood_page_mode.dart';

class DashboardAssignments extends StatelessWidget {
  final DateTime date;

  const DashboardAssignments({
    Key? key,
    required this.date,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    // context.router.push(CreateMoodRoute(mode: const MoodPageMode.create(), date: date));
  }

  // void _onMoodItemPressedHandler(BuildContext context, Mood item) {
  //   // context.router.push(CreateMoodRoute(mode: MoodPageMode.edit(moodRecord: item), date: date));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24.0, right: 16.0, left: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          return state.maybeMap(
            loading: (_) => const Loader(),
            orElse: () {
              final bool isEditable = DashboardUtils.isEditable(date);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppIcons.dashboardAssignments,
                          const SizedBox(width: 24.0),
                          Text(
                            LocalizedTexts.assignments,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                ),
                          ).tr(),
                        ],
                      ),
                      if (isEditable)
                        const ImageIcon(
                          AppIcons.arrow,
                          color: AppColors.greyLabel,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(color: AppColors.ff404040),
                  if (state.data.questionsForCurrentWeek(date).isEmpty)
                    Text(
                      LocalizedTexts.allAssignmentsCompleted,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: ThemeConstants.fontSize14,
                            color: AppColors.greyLabel,
                          ),
                    ).tr(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
