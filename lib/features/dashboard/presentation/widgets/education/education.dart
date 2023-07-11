import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/education/widgets/completed_lesson.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/education/widgets/next_lesson.dart';
import 'package:loopcare_frontend/features/home/application/home_bottom_navigation_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

class Education extends StatelessWidget {
  final DateTime date;

  const Education({
    Key? key,
    required this.date,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    context
        .read<HomeBottomNavigationBloc>()
        .add(const HomeBottomNavigationEvent.tabChanged(DashboardNavbarItems.education));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardEducationBloc, DashboardEducationState>(
      builder: (BuildContext context, state) {
        final nextLesson = state.data.nextLesson;
        final completedLessons = state.data.completedLessons[date.isoStringWithoutTime];

        return Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 16.0, left: 16.0),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => onPressHandler(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Image(image: AppImages.educationDashboard),
                        const SizedBox(width: 24.0),
                        Text(
                          LocalizedTexts.education.translation,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontFamily: ThemeConstants.bitterFontFamily,
                                color: state.data.isLoading ? AppColors.greyLabel : AppColors.darkGreen,
                              ),
                        ),
                      ],
                    ),
                    if (!state.data.isLoading)
                      const ImageIcon(
                        AppIcons.arrow,
                        color: AppColors.greyLabel,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (nextLesson != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(color: AppColors.yellowLight),
                        const SizedBox(height: 6.0),
                        Text(
                          LocalizedTexts.todo,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: ThemeConstants.fontSize12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyLabel,
                              ),
                        ).tr(),
                        const SizedBox(height: 12.0),
                        NextLesson(
                          lesson: nextLesson,
                        ),
                        const SizedBox(height: 14.0),
                      ],
                    ),
                  if (completedLessons != null && completedLessons.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(color: AppColors.yellowLight),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${LocalizedTexts.done.translation} ${_getDate(date).toUpperCase()}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: ThemeConstants.fontSize12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyLabel,
                              ),
                        ),
                        const SizedBox(height: 20.0),
                        ListView.separated(
                          itemCount: completedLessons.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            return CompletedLesson(
                              lesson: completedLessons[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 20.0);
                          },
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getDate(DateTime date) {
    return date.isoStringWithoutTime == DateTime.now().isoStringWithoutTime
        ? LocalizedTexts.today.translation
        : date.shortDate;
  }
}
