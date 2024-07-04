import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

@RoutePage()
class AssignmentsSavedPage extends StatelessWidget {
  final RiverModuleStreamType streamType;

  const AssignmentsSavedPage({super.key, this.streamType = RiverModuleStreamType.psychology});

  _onPressHandler(BuildContext context) {
    context.read<DashboardEducationBloc>().add(const DashboardEducationEvent.getDashboardLessons());
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  _onErrorListener(BuildContext context, EducationLessonState state) {
    final errorMessage = state.data.errorMessage ?? LocalizedTexts.somethingWentWrong;
    context.showError(content: CustomText(errorMessage.tr()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EducationLessonBloc, EducationLessonState>(
      listenWhen: (prev, cur) => cur is ErrorCompleteLesson,
      listener: _onErrorListener,
      child: CustomScaffold(
        color: streamType.offRegularColor,
        appBar: CustomAppBar(
          backgroundColor: streamType.regularColor,
          textTheme: streamType.appBarTextTheme,
          title: LocalizedTexts.lesson.tr(),
          leading: CustomFilledIconButton.fromColor(color: streamType.lighterColor),
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
                                '${LocalizedTexts.assignmentCompleted.tr()}!',
                                style: context.textTheme.displayMedium
                                    ?.copyWith(color: AppColors.white),
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
                          children: [
                            BlocBuilder<AssignmentsBloc, AssignmentsState>(
                              builder: (context, state) {
                                // final questions =
                                //     state.data.questionsForLesson(state.data.lessonId);
                                //
                                // final questionTitle = questions.first.title;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CategoryLabel.assignment(),
                                    const SizedBox(height: 20.0),
                                    CustomText.bitter600(
                                      'asd',
                                      style: context.textTheme.displayLarge,
                                    ),
                                    const SizedBox(height: 20.0),
                                    CustomText.w400(
                                      LocalizedTexts.assignmentCompleteDescription.tr(),
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                MainContainer(
                  child: Column(
                    children: [
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onPressHandler(context),
                        label: LocalizedTexts.complete.tr(),
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
