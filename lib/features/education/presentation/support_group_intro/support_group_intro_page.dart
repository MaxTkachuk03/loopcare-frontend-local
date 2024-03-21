import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_page_mode.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/injection.dart';

class SupportGroupIntroPage extends StatelessWidget {
  const SupportGroupIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CustomScaffold.petrolLightest(
        appBar: CustomAppBar.petrol(
          title: LocalizedTexts.theSupportGroup.tr(),
          subtitle: LocalizedTexts.introduction.tr(),
          leading: CustomFilledIconButton.leadingPetrolLighter(),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SimpleProgressBar.petrol(
              progress: context.read<EducationLessonBloc>().state.data.lessonProgress,
            ),
          ),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 30.0),
                      BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (context, state) {
                          final lesson = state.data;

                          return SizedBox(height: 265, child: NetworkImageWithCache(url: lesson.lessonImage));
                        },
                      ),
                      const SizedBox(height: 28.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryLabel.groupSession(),
                      const SizedBox(height: 18.0),
                      CustomText.bitter600(
                        LocalizedTexts.yourSupportSystem.tr(),
                        style: context.textTheme.displayLarge,
                      ),
                      const SizedBox(height: 18.0),
                      CustomText.w400(
                        LocalizedTexts.supportGroupIntroDesc.tr(),
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  Column(
                    children: [
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onJoinPressed(context),
                        label: LocalizedTexts.yesILikeToJoin.tr(),
                      ),
                      const SizedBox(height: 12.0),
                      CustomOutlinedButton.blueFullWidth(
                        onPressed: () => _onDoNotJoinPressed(context),
                        label: LocalizedTexts.joinLater.tr(),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onJoinPressed(BuildContext context) {
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.iWantToJoinToGroup,
      parameters: {
        CustomDefinitions.navigatedFrom: 'Lesson content',
        CustomDefinitions.decision: LocalizedTexts.yesILikeToJoin.tr()
      },
    );

    if (getIt<SharedStorageService>().account!.medicalOnboarding!.treatedByPsychiatrist) {
      context.router.push(ConsultDoctorRoute(mode: const ExtraActionPageMode.afterLesson()));
      return;
    }

    if (!getIt<SharedStorageService>().account!.subscription.isActive) {
      context.router.push(NeedPaidSubscriptionRoute(mode: const ExtraActionPageMode.afterLesson()));
      return;
    }

    context
      ..read<GroupPreferencesBloc>().add(const GroupPreferencesEvent.setWouldLikeJoinGroup(YesNoAnswer.yes))
      ..read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward())
      ..router.push(GenderPreferencesRoute(fromLessonComplete: true));
  }

  _onDoNotJoinPressed(BuildContext context) {
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.iWantToJoinToGroup,
      parameters: {
        CustomDefinitions.navigatedFrom: 'Lesson content',
        CustomDefinitions.decision: LocalizedTexts.joinLater.tr()
      },
    );

    context.router.pushNamed(AppRoutes.lessonComplete);
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressBack());

    return Future.value(true);
  }
}
