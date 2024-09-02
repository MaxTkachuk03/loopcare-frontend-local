import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/domain/dashboard_utils.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/person_mood/mood_list.dart';
import 'package:loopcare_frontend/features/mood/application/mood_bloc.dart';
import 'package:loopcare_frontend/features/mood/domain/mood.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_page_mode.dart';

class PersonMood extends StatelessWidget {
  final DateTime date;

  const PersonMood({super.key, required this.date});

  void onPressHandler(BuildContext context) {
    context.router.push(CreateMoodRoute(mode: const MoodPageMode.create(), date: date));
  }

  void _onMoodItemPressedHandler(BuildContext context, Mood item) {
    context.router.push(CreateMoodRoute(mode: MoodPageMode.edit(moodRecord: item), date: date));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0, right: 8.0, left: 8.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          return state.maybeMap(
            loading: (_) => const Loader(),
            orElse: () {
              final bool isEditable = DashboardUtils.isEditable(date);
              final List<Mood> moodValues = state.data.getSelectedDayMoods(date.isoStringWithoutTime);
              moodValues.sort((a, b) => a.time.compareTo(b.time));

              final Color textColor = isEditable ? AppColors.blueDarker : AppColors.greyLabel;

              return Column(
                children: [
                  DashboardCardTitle(
                    onTap: () => onPressHandler(context),
                    highlightColor: AppColors.orangeLightest,
                    leadingIcon: AppIcons.customDashboardMood,
                    title: CustomText.bitter600(
                      LocalizedTexts.mood.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(color: textColor),
                    ),
                    actionIcon: AppIcons.plus,
                    editable: isEditable,
                  ),
                  const Divider(
                    color: AppColors.blueLighter,
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                  const SizedBox(height: 4.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MoodList(
                      list: moodValues,
                      isEditable: isEditable,
                      onPressItem: (Mood item) => _onMoodItemPressedHandler(context, item),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
