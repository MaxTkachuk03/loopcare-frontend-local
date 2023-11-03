import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_controller.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_emotion.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_food.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_option_page_mode.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_where.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_with_who.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/emotions_list.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_option_item.dart';

class MoodOptions extends StatelessWidget {
  final MoodController controller;

  const MoodOptions({super.key, required this.controller});

  _onPressHandler(BuildContext context, MoodOptionPageMode mode) =>
      () => context.router.push(MoodOptionRoute(mode: mode, controller: controller));

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            ValueListenableBuilder<DateTime?>(
              valueListenable: controller.timeValue,
              builder: (context, timeValue, _) {
                final subTitle =
                    timeValue != null ? timeValue.timeHoursMinutes12 : LocalizedTexts.makeChoice.tr();

                return MoodOptionItem(
                  title: LocalizedTexts.time.tr(),
                  subTitle: Text(subTitle, style: Theme.of(context).textTheme.titleLarge),
                  onPressed: _onPressHandler(context, const MoodOptionPageMode.time()),
                );
              },
            ),
            const Divider(height: 1.0, color: AppColors.FF404040),
            ValueListenableBuilder<List<MoodEmotion>>(
              valueListenable: controller.emotionValues,
              builder: (context, emotionValues, _) {
                final subTitle = emotionValues.isEmpty
                    ? Text(LocalizedTexts.makeChoice, style: Theme.of(context).textTheme.titleLarge).tr()
                    : EmotionsList(data: emotionValues);

                return MoodOptionItem(
                  title: LocalizedTexts.specifyEmotion.tr(),
                  subTitle: subTitle,
                  onPressed: _onPressHandler(context, const MoodOptionPageMode.emotion()),
                );
              },
            ),
            const Divider(height: 1.0, color: AppColors.FF404040),
            ValueListenableBuilder<List<MoodWithWho>>(
              valueListenable: controller.withWhoValues,
              builder: (context, withWhoValue, _) {
                final subTitle = withWhoValue.isEmpty
                    ? LocalizedTexts.makeChoice
                    : withWhoValue.map((e) => e.value).join(', ').toString();

                return MoodOptionItem(
                  title: LocalizedTexts.withWho.tr(),
                  subTitle: Text(subTitle, style: Theme.of(context).textTheme.titleLarge),
                  onPressed: _onPressHandler(context, const MoodOptionPageMode.withWho()),
                );
              },
            ),
            const Divider(height: 1.0, color: AppColors.FF404040),
            ValueListenableBuilder<List<MoodWhere>>(
              valueListenable: controller.whereValues,
              builder: (context, whereValues, _) {
                final subTitle = whereValues.isEmpty
                    ? LocalizedTexts.makeChoice
                    : whereValues.map((e) => e.value).join(', ').toString();

                return MoodOptionItem(
                  title: LocalizedTexts.where.tr(),
                  subTitle: Text(subTitle, style: Theme.of(context).textTheme.titleLarge),
                  onPressed: _onPressHandler(context, const MoodOptionPageMode.where()),
                );
              },
            ),
            const Divider(height: 1.0, color: AppColors.FF404040),
            ValueListenableBuilder<List<MoodFood>>(
              valueListenable: controller.foodValues,
              builder: (context, foodValues, _) {
                final subTitle = foodValues.isEmpty
                    ? LocalizedTexts.makeChoice
                    : foodValues.map((e) => e.value).join(', ').toString();

                return MoodOptionItem(
                  title: LocalizedTexts.food.tr(),
                  subTitle: Text(subTitle, style: Theme.of(context).textTheme.titleLarge),
                  onPressed: _onPressHandler(context, const MoodOptionPageMode.food()),
                );
              },
            ),
          ],
        ));
  }
}
