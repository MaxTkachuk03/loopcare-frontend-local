import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
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
import 'package:loopcare_frontend/features/assignments/application/assignments_bloc.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/utils/get_label_by_category.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/save_assignment.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_assignment.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_buddy_feature.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_food_logging_feature.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_group_session_feature.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

class LessonCompletePage extends StatefulWidget {
  final bool joinSupportGroupLater;

  const LessonCompletePage({super.key, this.joinSupportGroupLater = false});

  @override
  State<LessonCompletePage> createState() => _LessonCompletePageState();
}

class _LessonCompletePageState extends State<LessonCompletePage> {
  bool showedAssignment = false;

  @override
  void initState() {
    super.initState();
    if (context.read<EducationLessonBloc>().state.data.isLessonCompleted) {
      return;
    }
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.completeLesson());
  }

  _onPressHandler(BuildContext context) {
    context.read<DashboardEducationBloc>().add(const DashboardEducationEvent.getDashboardLessons());
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  _onErrorListener(BuildContext context, EducationLessonState state) {
    final errorMessage = state.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr();
    context.showError(content: Text(errorMessage));
  }

  _startLessonQuestion(int lessonId) {
    context.router.push(AssignmentsIntroRoute(lessonId: lessonId, fromDashboard: false));

    setState(() {
      showedAssignment = true;
    });
  }

  bool get _isGroupSessionsDisabled => getIt<SharedStorageService>().account!.disableGroupSessions;

  String _subText(EducationLessonState state) {
    if (state.data.extraAction == ExtraActionTypes.setupGroupingPreferences && !_isGroupSessionsDisabled) {
      return LocalizedTexts.lessonCompleteDescription.tr();
    }

    if (state.data.extraAction == ExtraActionTypes.unlockMeals ||
        (state.data.extraAction == ExtraActionTypes.setupGroupingPreferences && !_isGroupSessionsDisabled)) {
      return LocalizedTexts.unlockFeatureDescription.tr();
    } else {
      return LocalizedTexts.lessonCompleteDescription.tr();
    }
  }

  _lessonCompleteListener(BuildContext context, EducationLessonState state) =>
      context.read<AuthenticationBloc>().add(const AuthenticationEvent.getAccount());

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EducationLessonBloc, EducationLessonState>(
          listenWhen: (prev, cur) => cur is ErrorCompleteLesson,
          listener: _onErrorListener,
        ),
        BlocListener<EducationLessonBloc, EducationLessonState>(
          listenWhen: (prev, cur) => cur is LessonCompleted,
          listener: _lessonCompleteListener,
        ),
      ],
      child: CustomScaffold.petrol(
        appBar: CustomAppBar.petrol(
          title: LocalizedTexts.lesson.tr(),
          leading: CustomFilledIconButton.leadingPetrolLighter(),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    UnderAppbar.petrol(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 22.0,
                                backgroundColor: AppColors.greenRegular,
                                child: Icon(Icons.check, size: 24, color: AppColors.white),
                              ),
                              const SizedBox(height: 22.0),
                              CustomText.bitter600(
                                '${LocalizedTexts.lessonCompleted.tr()}!',
                                style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
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
                                final lesson = state.data;
                                if (state.data.isLessonCompleted) {
                                  AnalyticsEventService.instance.logLessonCompletedEvent(
                                    FirebaseEvents.lessonCompletedScreen,
                                    context.read<EducationLessonBloc>().state.data.lessonId,
                                  );
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getLabelByCategory(lesson.lessonCategory),
                                    const SizedBox(height: 10.0),
                                    CustomText.bitter600(
                                      lesson.lessonTitle,
                                      style: context.textTheme.displayLarge,
                                    ),
                                    const SizedBox(height: 10.0),
                                    if (state.data.extraAction != ExtraActionTypes.unlockBuddy)
                                      CustomText.w400(_subText(state), style: context.textTheme.bodyMedium),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MainContainer(
                      child: BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (BuildContext context, state) {
                          if (state.data.isFoodLoggingUnlocked) {
                            return const UnlockFoodLoggingFeature();
                          }

                          if (state.data.isBuddyUnlocked) {
                            return const UnlockBuddyFeature();
                          }

                          if (state.data.extraAction == ExtraActionTypes.setupGroupingPreferences &&
                              !_isGroupSessionsDisabled) {
                            return UnlockGroupSessionFeature(wantJoinLater: widget.joinSupportGroupLater);
                          }

                          if (state.data.assignmentsQuestions.isNotEmpty &&
                              state.data.assignmentsQuestionsWithAnswers.isEmpty) {
                            final accountCreatedDate =
                                getIt<SharedStorageService>().account?.createdAt ?? DateTime.now();

                            context.read<AssignmentsBloc>().add(
                                  AssignmentsEvent.getAllLessonQuestions(
                                    accountCreatedDate,
                                    DateTime.now(),
                                  ),
                                );

                            return showedAssignment
                                ? const SavedAssignment()
                                : UnlockAssignment(
                                    completedAt: state.data.lessonCompletedDate ?? DateTime.now(),
                                    onBtnPressed: () => _startLessonQuestion(state.data.lessonId),
                                  );
                          }

                          return const SizedBox.shrink();
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
                        label: LocalizedTexts.backToEducation.tr(),
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
}
