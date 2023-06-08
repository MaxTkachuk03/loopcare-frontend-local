import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/survey_image_clipper.dart';
import 'package:loopcare_frontend/features/education/application/dto/lesson_content.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

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
        child: Column(
          children: [
            BlocBuilder<EducationLessonBloc, EducationLessonState>(
                builder: (BuildContext context, state) {
              final lesson = state.data;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipPath(
                    clipper: SurveyImageClipper(),
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      color: AppColors.white,
                    ),
                  ),
                  Positioned(
                    bottom: -90,
                    left: 1,
                    right: 1,
                    child: SizedBox(
                      height: 180,
                      child: NetworkImageWithCache(url: lesson.lessonImage),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 60.0),
            Expanded(
              child: ScrollableContainer(
                child: MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20.0),
                      BlocBuilder<EducationLessonBloc, EducationLessonState>(
                        builder: (context, state) {
                          final lesson = state.data;

                          return Text(
                            lesson.lessonCategory.toUpperCase(),
                            style: const TextStyle(
                                color: AppColors.orangeDark,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600),
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      HtmlRenderer(content: content.html),
                      const SizedBox(height: 40.0),
                      ElevatedButton(
                        onPressed: onNextPressed,
                        child: const Text(LocalizedTexts.next).tr(),
                      ),
                      const SizedBox(height: 14.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
