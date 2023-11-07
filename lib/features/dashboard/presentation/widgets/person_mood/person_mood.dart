import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/dashboard/domain/dashboard_utils.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/person_mood/mood_list.dart';
import 'package:loopcare_frontend/features/mood/application/mood_bloc.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_page_mode.dart';

class PersonMood extends StatelessWidget {
  final DateTime date;

  const PersonMood({Key? key, required this.date}) : super(key: key);

  void onPressHandler(BuildContext context) {
    context.router.push(CreateMoodRoute(mode: const MoodPageMode.create(), date: date));
  }

  void _onMoodItemPressedHandler(BuildContext context, Mood item) {
    context.router.push(CreateMoodRoute(mode: MoodPageMode.edit(moodRecord: item), date: date));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24.0, right: 16.0, left: 16.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          return state.maybeMap(
            updated: (s) {
              final bool isEditable = DashboardUtils.isEditable(date);
              final List<Mood> moodValues = s.data.getSelectedDayMoods(date.isoStringWithoutTime);

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppIcons.dashboardMood,
                          const SizedBox(width: 24.0),
                          Text(
                            LocalizedTexts.mood,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                ),
                          ).tr(),
                        ],
                      ),
                      if (isEditable)
                        Hexagon(
                          width: 42,
                          height: 42,
                          borderRadius: 16,
                          innerWidget: Container(
                            color: AppColors.bgGreen,
                            child: IconButton(
                              icon: const ImageIcon(
                                AppIcons.plus,
                                color: AppColors.darkGreen,
                                size: 12,
                              ),
                              onPressed: () => onPressHandler(context),
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(color: AppColors.yellowLight),
                  MoodList(
                    list: moodValues,
                    onPressItem: (Mood item) => _onMoodItemPressedHandler(context, item),
                  ),
                ],
              );
            },
            loading: (_) => const Loader(),
            error: (errorState) {
              final error = errorState.data.error;

              return ErrorScreen(
                smallVersion: true,
                error: error,
                onButtonPressed: () => context
                    .read<MoodBloc>()
                    .add(MoodEvent.getMoods(date.toUtc().toIso8601String(), date.toUtc().toIso8601String())),
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
