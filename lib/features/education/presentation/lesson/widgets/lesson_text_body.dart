import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_content.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/utils/get_label_by_category.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/lesson_image_header.dart';

class LessonTextBody extends StatelessWidget {
  final LessonContent content;
  final void Function() onNextPressed;

  const LessonTextBody({super.key, required this.content, required this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        children: [
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, accountState) {
              return BlocBuilder<EducationLessonBloc, EducationLessonState>(
                builder: (context, state) {
                  if (state.data.extraAction == ExtraActionTypes.setupGroupingPreferences &&
                      accountState.groupingState == UserGroupingState.locked) {
                    return SimpleProgressBar(
                      progress: state.data.lessonProgress,
                      backgroundColor: AppColors.white,
                    );
                  }

                  return const SizedBox.shrink();
                },
              );
            },
          ),
          const SizedBox(height: 32.0),
          const LessonImageHeader(),
          const SizedBox(height: 28.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<EducationLessonBloc, EducationLessonState>(
                builder: (context, state) {
                  final lesson = state.data;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: getLabelByCategory(lesson.lessonCategory),
                  );
                },
              ),
              const SizedBox(height: 18.0),
              HtmlRenderer(content: content.html),
              const SizedBox(height: 64.0),
              MainContainer(
                child: CustomElevatedButton.blueFullWidth(
                  onPressed: onNextPressed,
                  label: LocalizedTexts.next.tr(),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ],
      ),
    );
  }
}
