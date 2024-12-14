import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
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
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class PersonMood extends StatefulWidget {
  final DateTime date;
  final bool locked;

  const PersonMood({super.key, required this.date, required this.locked});

  @override
  State<PersonMood> createState() => _PersonMoodState();
}

class _PersonMoodState extends State<PersonMood> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  void onPressHandler(BuildContext context) {
    context.router.push(CreateMoodRoute(mode: const MoodPageMode.create(), date: widget.date));
  }

  void _onMoodItemPressedHandler(BuildContext context, Mood item) {
    context.router
        .push(CreateMoodRoute(mode: MoodPageMode.edit(moodRecord: item), date: widget.date));
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
              final bool isEditable = DashboardUtils.isEditable(widget.date);
              final List<Mood> moodValues =
                  state.data.getSelectedDayMoods(widget.date.isoStringWithoutTime);
              moodValues.sort((a, b) => a.time.compareTo(b.time));

              final Color textColor = isEditable ? AppColors.blueDarker : AppColors.greyLabel;

              return Column(
                children: [
                  DashboardCardTitle(
                    onTap: () {
                      if (widget.locked) {
                        onPressHandler(context);
                      } else {
                        toggleOnClick();
                      }
                    },
                    highlightColor: widget.locked ? AppColors.orangeLightest : AppColors.white,
                    leadingIcon: widget.locked
                        ? AppIcons.customDashboardMood
                        : AppIcons.customDashboardMoodGrey,
                    title: widget.locked
                        ? CustomText.bitter600(
                            LocalizedTexts.mood.tr(),
                            style: context.textTheme.headlineSmall?.copyWith(color: textColor),
                          )
                        : CustomText.bitter400(
                            LocalizedTexts.mood.tr(),
                            style: context.textTheme.headlineSmall?.copyWith(color: textColor),
                          ),
                    actionIcon: widget.locked
                        ? AppIcons.plus
                        : onClick
                            ? const AssetImage(AppIcons.upArrow)
                            : AppIcons.downArrow,
                    editable: isEditable,
                  ),
                  widget.locked
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              AppIcons.lockGoals,
                              const SizedBox(
                                width: 36,
                              ),
                              SizedBox(
                                width: 250,
                                child: CustomText.w400(
                                  "${LocalizedTexts.featureUnlocksAtPool.tr()} #${LocalizedTexts.moodLog.tr()}",
                                  style: const TextStyle(color: AppColors.blueDarker),
                                ),
                              ),
                            ],
                          ),
                        ),
                  onClick
                      ? SizedBox(
                          width: 250,
                          child: CustomText.w400(
                            maxLines: 10,
                            LocalizedTexts.moodLogLockedDescription.tr(),
                          ),
                        )
                      : Container(),
                  widget.locked
                      ? const Divider(
                          color: AppColors.blueLighter,
                          indent: 8.0,
                          endIndent: 8.0,
                        )
                      : const SizedBox(),
                  widget.locked ? const SizedBox(height: 4.0) : const SizedBox(),
                  widget.locked
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MoodList(
                            list: moodValues,
                            isEditable: isEditable,
                            onPressItem: (Mood item) => _onMoodItemPressedHandler(context, item),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
