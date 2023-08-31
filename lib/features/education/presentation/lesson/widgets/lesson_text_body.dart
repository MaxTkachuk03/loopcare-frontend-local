import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_content.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/lesson_image_header.dart';

class LessonTextPage extends StatelessWidget {
  final LessonContent content;
  final void Function() onNextPressed;
  final void Function() onPrevPressed;

  const LessonTextPage({
    Key? key,
    required this.content,
    required this.onNextPressed,
    required this.onPrevPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onPrevPressed,
        ),
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            children: [
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, accountState) {
                  return BlocBuilder<EducationLessonBloc, EducationLessonState>(
                    builder: (context, state) {
                      if (state.data.extraAction == ExtraActionTypes.setupGroupingPreferences &&
                          accountState.groupingState == UserGroupingState.locked) {
                        return ProgressBar(
                          progress: state.data.lessonProgress,
                          backgroundColor: AppColors.white,
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
              const LessonImageHeader(),
              const SizedBox(height: 60.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20.0),
                  BlocBuilder<EducationLessonBloc, EducationLessonState>(
                    builder: (context, state) {
                      final lesson = state.data;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          lesson.lessonCategory.toUpperCase(),
                          style: const TextStyle(
                              color: AppColors.orangeDark, fontSize: 12.0, fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                  HtmlRenderer(content: content.html),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed: onNextPressed,
                      child: const Text(LocalizedTexts.next).tr(),
                    ),
                  ),
                  const SizedBox(height: 14.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
