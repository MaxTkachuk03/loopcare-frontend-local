import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/lesson_image_header.dart';

class SupportGroupIntroPage extends StatelessWidget {
  const SupportGroupIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LocalizedTexts.theSupportGroup,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ).tr(),
              Text(
                LocalizedTexts.introduction,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).tr(),
            ],
          ),
          backgroundColor: AppColors.white,
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              children: [
                BlocBuilder<EducationLessonBloc, EducationLessonState>(
                  builder: (context, state) {
                    if (state.data.extraAction == ExtraActionTypes.setupGroupingPreferences) {
                      return ProgressBar(
                        progress: state.data.lessonProgress,
                        backgroundColor: AppColors.white,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const LessonImageHeader(),
                const SizedBox(height: 110.0),
                MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        LocalizedTexts.yourSupportSystem,
                        style: TextStyle(
                          fontSize: ThemeConstants.fontSize30,
                          fontFamily: ThemeConstants.bitterFontFamily,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blueDark,
                        ),
                      ).tr(),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        LocalizedTexts.supportGroupIntroDesc,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).tr(),
                      const SizedBox(
                        height: 38.0,
                      ),
                      ElevatedButton(
                        onPressed: () => _onJoinPressed(context),
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                            ),
                        child: const Text(LocalizedTexts.yesILikeToJoin).tr(),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      OutlinedButton(
                        onPressed: () => _onDoNotJoinPressed(context),
                        child: const Text(LocalizedTexts.joinLater).tr(),
                      )
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

  _onJoinPressed(BuildContext context) {
    context
      ..read<AuthenticationCubit>().unlockFeature(UnlockedFeatureType.grouping.name)
      ..read<GroupPreferencesBloc>().add(const GroupPreferencesEvent.setWouldLikeJoinGroup(YesNoAnswer.yes))
      ..read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward())
      ..router.pushNamed(AppRoutes.genderPreferences);
  }

  _onDoNotJoinPressed(BuildContext context) {
    context.read<AuthenticationCubit>().unlockFeature(UnlockedFeatureType.grouping.name);

    context.router.pushNamed(AppRoutes.lessonComplete);
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressBack());

    return Future.value(true);
  }
}
