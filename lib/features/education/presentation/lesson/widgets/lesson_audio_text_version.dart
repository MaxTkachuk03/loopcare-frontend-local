import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/survey_image_clipper.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class LessonAudioTextVersion extends StatelessWidget {
  const LessonAudioTextVersion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationLessonBloc, EducationLessonState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: AppColors.white),
          body: SafeArea(
            child: Column(
              children: [
                Stack(
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
                      left: 1,
                      right: 1,
                      child: SizedBox(
                        height: 140,
                        child:
                            NetworkImageWithCache(url: state.data.lessonImage),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Expanded(
                  child: ScrollableContainer(
                    child: MainContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20.0),
                          Text(
                            state.data.lessonCategory.toUpperCase(),
                            style: const TextStyle(
                                color: AppColors.orangeDark,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            state.data.lessonTitle,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                ),
                          ),
                          const SizedBox(height: 24.0),
                          HtmlRenderer(
                              content: state.data.currentPage.content.html),
                          const SizedBox(height: 40.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
