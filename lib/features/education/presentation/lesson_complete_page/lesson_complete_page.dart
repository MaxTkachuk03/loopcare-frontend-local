import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_error_widget/error_invoker.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/utils/get_label_by_stream_type.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_group_session_feature.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/injection.dart';

@RoutePage()
class LessonCompletePage extends StatefulWidget {
  final RiverModuleStreamType streamType;

  const LessonCompletePage({
    super.key,
    this.streamType = RiverModuleStreamType.community,
  });

  @override
  State<LessonCompletePage> createState() => _LessonCompletePageState();
}

class _LessonCompletePageState extends State<LessonCompletePage> {
  bool _hasReflection = false;

  @override
  void initState() {
    super.initState();

    final activeModuleItem = context.read<RiverBloc>().state.data.activeModuleItem;

    context.read<RiverBloc>().add(const RiverEvent.updateActiveModuleItemStatus());

    if (activeModuleItem == null) return;

    _hasReflection = activeModuleItem.unlocksReflectionId != null &&
        activeModuleItem.states.itemState.isUnLocked;
  }

  void _onPressHandler(BuildContext context) {
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  void _onErrorListener(BuildContext context, EducationLessonState state) =>
      context.showError(content: CustomText(state.data.errorKey.tr()));

  void _onModuleItemCompleteListener(BuildContext context, RiverState state) {
    if (_hasReflection) {
      context.read<ReflectionsBloc>().add(const ReflectionsEvent.getReflections());
    }

    const AnalyticsEventService().logLessonCompletedEvent(
      AnalyticsEvents.lessonCompletedScreen,
      context.read<EducationLessonBloc>().state.data.id,
    );
  }

  CustomAppBarTextTheme get _theme => widget.streamType.appBarTextTheme;

  bool get _isLightTheme => _theme == CustomAppBarTextTheme.light;

  bool get _isGroupSessionsDisabled => getIt<SharedStorageService>().account!.disableGroupSessions;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EducationLessonBloc, EducationLessonState>(
          listenWhen: (prev, cur) => cur is ErrorCompleteLesson,
          listener: _onErrorListener,
        ),
        BlocListener<RiverBloc, RiverState>(
          listenWhen: (prev, cur) =>
              prev is RiverStateModuleItemLoading &&
              (cur is RiverStateModuleItemLoaded || cur is RiverStateModuleLoaded),
          listener: _onModuleItemCompleteListener,
        ),
      ],
      child: CustomScaffold(
        color: widget.streamType.offRegularColor,
        appBar: CustomAppBar(
          backgroundColor: widget.streamType.regularColor,
          textTheme: _theme,
          title: LocalizedTexts.lesson.tr(),
          leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
          actions: const [ErrorInvokeButton()],
        ),
        body: CustomSafeArea(
          child: ErrorInvoker(
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
                                  backgroundColor: _isLightTheme
                                      ? AppColors.greenRegular
                                      : AppColors.blueRegular,
                                  child: const Icon(Icons.check, size: 24, color: AppColors.white),
                                ),
                                const SizedBox(height: 22.0),
                                CustomText.bitter600(
                                  '${LocalizedTexts.lessonCompleted.tr()}!',
                                  style: context.textTheme.displayMedium?.copyWith(
                                      color:
                                          _isLightTheme ? AppColors.white : AppColors.blueDarker),
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
      ),
    );
  }
}
