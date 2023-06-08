import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';

class NextLesson extends StatelessWidget {
  final EducationLesson lesson;

  const NextLesson({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapHandler(context),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  lesson.category.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: ThemeConstants.fontSize12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.orangeDarkWithBlack,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  lesson.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.orangeDarkWithBlack,
                      ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    const Image(image: AppImages.arrowHexagon),
                    const SizedBox(
                      width: 12.0,
                    ),
                    AppIcons.clock,
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      formatDuration(lesson.duration),
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          const Image(image: AppImages.educationCardImage)
        ],
      ),
    );
  }

  _onTapHandler(BuildContext context) {
    context.read<EducationLessonBloc>().add(
          EducationLessonEvent.getLessonContent(
            lessonId: lesson.id,
            pageIndex: 0,
          ),
        );

    context.router.pushNamed('/lesson/${lesson.id}/page/0');
  }
}
