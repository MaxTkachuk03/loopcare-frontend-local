import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/interactive_lessons_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_group_session_feature.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/get_label_by_stream_type.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/lesson_type.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class LessonCompletePage extends StatefulWidget {
  final RiverModuleStreamType streamType;
  final LessonType lessonType;
  const LessonCompletePage({
    super.key,
    this.streamType = RiverModuleStreamType.community,
    this.lessonType = LessonType.simple,
  });

  @override
  State<LessonCompletePage> createState() => _LessonCompletePageState();
}

class _LessonCompletePageState extends State<LessonCompletePage> {
  final usageAnalytics = UsageAnalytics();

  @override
  void initState() {
    super.initState();

    final lesson = context.read<EducationLessonBloc>().state.data;
    context.read<RiverBloc>().add(RiverEvent.updateActiveModuleItemStatus(lessonId: lesson.id));
    final riverModule = context.read<RiverBloc>().state.data.activeModule;

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.lessonCompleted,
      attributes: {
        UsageAnalyticsAttributes.articleId: lesson.id,
        UsageAnalyticsAttributes.articleTitle: lesson.title,
        UsageAnalyticsAttributes.articlePool: riverModule?.title,
      },
    );

    const AnalyticsEventService().logLessonCompletedEvent(
      AnalyticsEvents.lessonCompletedScreen,
      lesson.id,
    );
  }

  void _onPressHandler(BuildContext context) {
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  void _onErrorListener(BuildContext context, state) => state.mapOrNull(
        errorCompleteLesson: (state) => context.showError(
          content: CustomText(state.data.errorKey.tr()),
        ),
      );

  CustomAppBarTextTheme get _theme => widget.streamType.appBarTextTheme;

  bool get _isLightTheme => _theme == CustomAppBarTextTheme.light;

  bool get _isGroupSessionsDisabled => getIt<SharedStorageService>().account!.disableGroupSessions;

  @override
  Widget build(BuildContext context) {
    return _checkLessonType(widget.lessonType);
  }

  Widget _regular() {
    return BlocListener<EducationLessonBloc, EducationLessonState>(
      listener: _onErrorListener,
      child: CustomScaffold(
        color: widget.streamType.offRegularColor,
        appBar: CustomAppBar(
          backgroundColor: widget.streamType.regularColor,
          textTheme: _theme,
          title: LocalizedTexts.lesson.tr(),
          leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    UnderAppbar(
                      fillColor: widget.streamType.regularColor,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 22.0,
                                backgroundColor:
                                    _isLightTheme ? AppColors.greenRegular : AppColors.blueRegular,
                                child: const Icon(Icons.check, size: 24, color: AppColors.white),
                              ),
                              const SizedBox(height: 22.0),
                              CustomText.bitter600(
                                LocalizedTexts.lessonCompleted.tr(),
                                style: context.textTheme.displayMedium?.copyWith(
                                  color: _isLightTheme ? AppColors.white : AppColors.blueDarker,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    MainContainer(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: const BoxDecoration(
                          color: AppColors.petrolLightest,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<EducationLessonBloc, EducationLessonState>(
                                builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getLabelByStreamType(widget.streamType),
                                  const SizedBox(height: 10.0),
                                  CustomText.bitter600(
                                    state.data.title,
                                    style: context.textTheme.displayLarge,
                                  ),
                                  const SizedBox(height: 10.0),
                                  CustomText.w400(
                                    state.data.conclusion,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MainContainer(
                      child: BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (BuildContext context, state) {
                          return BlocBuilder<RiverBloc, RiverState>(
                            builder: (context, s) {
                              if (state.data.unlockTitle.isEmpty ||
                                  state.data.unlockDescription.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              final isUnlockGroupSessions = state.data.extraAction ==
                                      ExtraActionTypes.setupGroupingPreferences &&
                                  !_isGroupSessionsDisabled;

                              if (isUnlockGroupSessions) {
                                return const UnlockGroupSessionFeature();
                              }

                              return FeatureUnlock(
                                title: state.data.unlockTitle,
                                body: state.data.unlockDescription,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                MainContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onPressHandler(context),
                        label: LocalizedTexts.backToThePool.tr(),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _interactive() {
    return BlocListener<InteractiveLessonsBloc, InteractiveLessonsState>(
      listener: _onErrorListener,
      child: CustomScaffold(
        color: widget.streamType.offRegularColor,
        appBar: CustomAppBar(
          backgroundColor: widget.streamType.regularColor,
          textTheme: _theme,
          title: LocalizedTexts.lesson.tr(),
          leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    UnderAppbar(
                      fillColor: widget.streamType.regularColor,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 22.0,
                                backgroundColor:
                                    _isLightTheme ? AppColors.greenRegular : AppColors.blueRegular,
                                child: const Icon(Icons.check, size: 24, color: AppColors.white),
                              ),
                              const SizedBox(height: 22.0),
                              CustomText.bitter600(
                                LocalizedTexts.lessonCompleted.tr(),
                                style: context.textTheme.displayMedium?.copyWith(
                                  color: _isLightTheme ? AppColors.white : AppColors.blueDarker,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    MainContainer(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: const BoxDecoration(
                          color: AppColors.petrolLightest,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
                                builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getLabelByStreamType(widget.streamType),
                                  const SizedBox(height: 10.0),
                                  CustomText.bitter600(
                                    state.data.title,
                                    style: context.textTheme.displayLarge,
                                  ),
                                  const SizedBox(height: 10.0),
                                  CustomText.w400(
                                    state.data.conclusion,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MainContainer(
                      child: BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
                        builder: (BuildContext context, state) {
                          return BlocBuilder<RiverBloc, RiverState>(
                            builder: (context, s) {
                              if (state.data.unlockTitle.isEmpty ||
                                  state.data.unlockDescription.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return FeatureUnlock(
                                title: state.data.unlockTitle,
                                body: state.data.unlockDescription,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                MainContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onPressHandler(context),
                        label: LocalizedTexts.backToThePool.tr(),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _checkLessonType(LessonType lessonType) {
    switch (lessonType) {
      case LessonType.simple:
        return _regular();
      case LessonType.interactive:
        return _interactive();
    }
  }
}
