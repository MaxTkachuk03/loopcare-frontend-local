import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/education/widgets/completed_lesson.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/education/widgets/next_lesson.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

class Education extends StatelessWidget {
  final DateTime date;

  const Education({super.key, required this.date});

  void onPressHandler(BuildContext context) {
    var tabsRouter = AutoTabsRouter.of(context);
    tabsRouter.setActiveIndex(DashboardNavbarItems.education.index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          DashboardCardTitle(
            onTap: () => onPressHandler(context),
            highlightColor: AppColors.petrolLightest,
            leadingIcon: AppIcons.customEducationDashboard,
            title: CustomText.bitter600(
              LocalizedTexts.education.tr(),
              style: context.textTheme.headlineSmall,
            ),
            actionIcon: AppIcons.arrow,
            circleButton: false,
          ),
          BlocBuilder<DashboardEducationBloc, DashboardEducationState>(
            builder: (context, state) {
              final nextLesson = state.data.nextLesson;
              final completedLessons = state.data.completedLessons[date.isoStringWithoutTime];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: AppColors.blueOffRegular,
                    ),
                    const SizedBox(height: 8.0),
                    state.maybeMap(
                      error: (errorState) {
                        final error = errorState.data.error;

                        return ErrorScreen(
                          error: error!,
                          onButtonPressed: () => context
                              .read<DashboardEducationBloc>()
                              .add(const DashboardEducationEvent.getDashboardLessons()),
                        );
                      },
                      loading: (_) => const SizedBox(height: 100.0, child: Loader()),
                      orElse: () {
                        if (nextLesson != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.bitter600(
                                LocalizedTexts.todo.tr(),
                                style: context.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8.0),
                              NextLesson(
                                lesson: nextLesson,
                              ),
                              const SizedBox(height: 14.0),
                            ],
                          );
                        }

                        if (completedLessons != null && completedLessons.isNotEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.bitter600(
                                '${LocalizedTexts.done.tr()} ${_getDate(date)}',
                                style: context.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 20.0),
                              ListView.separated(
                                itemCount: completedLessons.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CompletedLesson(lesson: completedLessons[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 20.0);
                                },
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getDate(DateTime date) {
    return date.isoStringWithoutTime == DateTime.now().isoStringWithoutTime
        ? LocalizedTexts.today.tr()
        : date.shortDate;
  }
}
