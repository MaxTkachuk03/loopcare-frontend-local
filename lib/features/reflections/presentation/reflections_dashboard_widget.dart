import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/custom_app_icon/custom_app_icon.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/presentation/widgets/reflections_list.dart';

class ReflectionsDashboardWidget extends StatelessWidget {
  final DateTime date;

  const ReflectionsDashboardWidget({super.key, required this.date});

  void _onErrorHandler(BuildContext context) =>
      context.read<ReflectionsBloc>().add(const ReflectionsEvent.getReflections());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardCardTitle(
              onTap: () => context.router.push(const MyReflectionsRoute()),
              highlightColor: AppColors.petrolLightest,
              leadingIcon: const CustomAppIcon.reflection(),
              title: CustomText.bitter600(
                LocalizedTexts.reflections.tr(),
                style: context.textTheme.headlineSmall,
              ),
              actionIcon: AppIcons.arrow,
              circleButton: false,
            ),
            const Divider(color: AppColors.blueLighter, indent: 8.0, endIndent: 8.0),
            BlocBuilder<ReflectionsBloc, ReflectionsState>(
              builder: (context, state) {
                final hasReflections = state.data.hasReflectionsForCurrentWeek(date);

                final selectedWeekReflections = state.data.getSelectedWeekUndoneReflections(date);

                final doneTodayReflections = state.data.getSelectedDayDoneReflections(date);

                final showDivider =
                    doneTodayReflections.isNotEmpty && selectedWeekReflections.isNotEmpty;

                return state.maybeMap(
                  loading: (_) => const SizedBox(height: 100, child: Loader()),
                  error: (errorState) {
                    final error = errorState.data.error;

                    return ErrorScreen(
                      error: error!,
                      onButtonPressed: () => _onErrorHandler(context),
                    );
                  },
                  orElse: () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: hasReflections
                        ? Column(
                            children: [
                              if (selectedWeekReflections.isNotEmpty)
                                ReflectionsList(
                                  list: selectedWeekReflections,
                                  title: LocalizedTexts.thisWeek.tr().capitalize(),
                                  fromDashboard: true,
                                ),
                              if (showDivider) const Divider(color: AppColors.blueLighter),
                              if (doneTodayReflections.isNotEmpty)
                                ReflectionsList(
                                  list: doneTodayReflections,
                                  title: LocalizedTexts.doneToday.tr().capitalize(),
                                  fromDashboard: true,
                                ),
                            ],
                          )
                        : CustomText.w400(
                            LocalizedTexts.allAssignmentsCompleted.tr(),
                            style: context.textTheme.bodyMedium,
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
