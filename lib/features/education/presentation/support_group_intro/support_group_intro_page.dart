import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_page_mode.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/injection.dart';

@RoutePage()
class SupportGroupIntroPage extends StatelessWidget {
  final RiverModuleStreamType streamType;

  const SupportGroupIntroPage({
    super.key,
    this.streamType = RiverModuleStreamType.psychology,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CustomScaffold(
        color: streamType.lightestColor,
        appBar: CustomAppBar(
          backgroundColor: streamType.regularColor,
          textTheme: streamType.appBarTextTheme,
          title: LocalizedTexts.theSupportGroup.tr(),
          subtitle: LocalizedTexts.introduction.tr(),
          leading: CustomFilledIconButton.fromColor(color: streamType.lighterColor),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SimpleProgressBar(
              backgroundColor: streamType.regularColor,
              progressFillColor: streamType.lightestColor,
              progressEmptyColor: AppColors.white.withOpacity(0.45),
              progress: context.read<EducationLessonBloc>().state.data.progress,
            ),
          ),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 30.0),
                      BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (context, state) => SizedBox(
                            height: 265,
                            child: NetworkImageWithCache(url: state.data.imageUrl),
                          ),
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

  void _onJoinPressed(BuildContext context) {
    final account = getIt<SharedStorageService>().account;

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.iWantToJoinToGroup,
      parameters: {
        AnalyticsParameters.navigatedFrom: 'Lesson content',
        AnalyticsParameters.decision: LocalizedTexts.yesILikeToJoin.tr()
      },
    );

    if (account!.isOnTrial) {
      context.router.push(NeedPaidSubscriptionRoute(
        mode: const ExtraActionPageMode.afterLesson(),
        streamType: streamType,
      ));
      return;
    }

    if (account.medicalOnboarding!.treatedByPsychiatrist) {
      context.router.push(ConsultDoctorRoute(
        mode: const ExtraActionPageMode.afterLesson(),
        streamType: streamType,
      ));
      return;
    }

    context
      ..read<GroupPreferencesBloc>()
          .add(const GroupPreferencesEvent.setWouldLikeJoinGroup(YesNoAnswer.yes))
      ..router.push(GenderPreferencesRoute(
        fromLessonComplete: true,
        streamType: streamType,
      ));
  }

  void _onDoNotJoinPressed(BuildContext context) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.iWantToJoinToGroup,
      parameters: {
        AnalyticsParameters.navigatedFrom: 'Lesson content',
        AnalyticsParameters.decision: LocalizedTexts.joinLater.tr()
      },
    );

    context.router.push(LessonCompleteRoute(streamType: streamType));
  }

  Future<bool> _onWillPop(BuildContext context) {
    return Future.value(true);
  }
}
