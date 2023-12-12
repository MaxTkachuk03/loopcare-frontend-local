import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';

class AssignmentsSavedPage extends StatelessWidget {
  const AssignmentsSavedPage({Key? key}) : super(key: key);

  _onPressHandler(BuildContext context) {
    context.read<DashboardEducationBloc>().add(const DashboardEducationEvent.getDashboardLessons());
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  _onErrorListener(BuildContext context, EducationLessonState state) {
    final errorMessage = state.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr();

    showAppSnackBar(
      context: context,
      text: errorMessage,
      background: AppColors.red,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EducationLessonBloc, EducationLessonState>(
      listenWhen: (prev, cur) => cur is ErrorCompleteLesson,
      listener: _onErrorListener,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: context.router.pop,
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
                      const SizedBox(height: 20.0),
                      BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (context, state) {
                          final lesson = state.data;
                          if (state.data.isLessonCompleted) {
                            AnalyticsEventService.instance.logLessonCompletedEvent(
                              'assignments_saved_screen',
                              context.read<EducationLessonBloc>().state.data.lessonId,
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                lesson.lessonCategory.toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.orangeDark,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 14.0),
                              Text(
                                lesson.lessonTitle,
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontSize: 24.0,
                                      fontFamily: ThemeConstants.bitterFontFamily,
                                    ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 36.0),
                      const Image(image: AppImages.lessonComplete),
                      const SizedBox(height: 32.0),
                      BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (BuildContext context, state) {
                          return Text(
                            '${LocalizedTexts.saved.translation}!'.capitalize(),
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _onPressHandler(context),
                        child: Text(LocalizedTexts.backToDashboard.tr()),
                      ),
                      const SizedBox(height: 30.0),
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
}
