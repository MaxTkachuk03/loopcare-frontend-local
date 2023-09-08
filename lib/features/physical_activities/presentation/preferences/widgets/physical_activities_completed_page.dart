import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_block.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/app_unlock_block.dart';

class PhysicalActivitiesCompletePage extends StatefulWidget {
  const PhysicalActivitiesCompletePage({Key? key}) : super(key: key);

  @override
  State<PhysicalActivitiesCompletePage> createState() => _PhysicalActivitiesCompletePageState();
}

class _PhysicalActivitiesCompletePageState extends State<PhysicalActivitiesCompletePage> {
  @override
  void initState() {
    if (context.read<EducationLessonBloc>().state.data.isLessonCompleted) {
      return;
    }

    context.read<EducationLessonBloc>().add(const EducationLessonEvent.completeLesson());

    super.initState();
  }

  _onPressHandler(BuildContext context) {
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  _onErrorListener(BuildContext context, EducationLessonState state) {
    showAppSnackBar(
      context: context,
      text: 'Something went wrong, try again',
      background: AppColors.red,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        // BlocListener<EducationLessonBloc, EducationLessonState>(
        //   listenWhen: (prev, cur) => cur is ErrorCompleteLesson,
        //   listener: _onErrorListener,
        //   child:
        Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          LocalizedTexts.physicalActivity,
                          style: TextStyle(
                            color: AppColors.orangeDark,
                            fontFamily: ThemeConstants.openSansFontFamily,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ).tr(),
                        const SizedBox(height: 14.0),
                        Text(
                          LocalizedTexts.physicalActivitiesCompletedTitle,
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 24.0,
                                fontFamily: ThemeConstants.bitterFontFamily,
                              ),
                        ).tr(),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Image(image: AppImages.lessonComplete),
                    const SizedBox(height: 30.0),
                    Text(
                      LocalizedTexts.completed.translation.capitalize(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      LocalizedTexts.physicalActivitiesCompletedDesc,
                      textAlign: TextAlign.center,
                    ).tr(),
                    const SizedBox(height: 24),
                    AppUnlockBlock(
                      title: LocalizedTexts.physicalActivitiesUnlockedTitle.translation.capitalize(),
                      text: LocalizedTexts.physicalActivitiesUnlockedText.translation.capitalize(),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                OutlinedButton(
                  onPressed: () => _onPressHandler(context),
                  child: Text(LocalizedTexts.backToToday.tr()),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
