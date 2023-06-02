import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';

import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/application/dto/education_lesson.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class EducationCard extends StatelessWidget {
  final EducationLesson lesson;
  static const _initialLessonPageIndex = 0;

  const EducationCard({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  _onTapHandler(BuildContext context) {
    context.read<EducationLessonBloc>().add(
          EducationLessonEvent.getLessonContent(
            lessonId: lesson.id,
            pageIndex: _initialLessonPageIndex,
          ),
        );

    context.router
        .pushNamed('/lesson/${lesson.id}/page/$_initialLessonPageIndex');
  }

  @override
  Widget build(BuildContext context) {
    Widget? icon;

    if (lesson.isCompleted) {
      icon = const ImageIcon(
        AppIcons.iconLock,
        color: AppColors.darkGreen,
      );
    }

    if (lesson.isCompleted) {
      icon = const Image(image: AppImages.play);
    }

    return GestureDetector(
      onTap: () => _onTapHandler(context),
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, bottom: 14.0, left: 20.0),
        decoration: BoxDecoration(
          color: lesson.isCompleted
              ? AppColors.white.withOpacity(0.6)
              : AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
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
                          fontWeight: lesson.isCompleted
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: lesson.isCompleted
                              ? AppColors.orangeDark
                              : AppColors.greyLabel,
                        ),
                  ),
                  const SizedBox(height: 14.0),
                  Text(
                    lesson.title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkGreen,
                        ),
                  ),
                  const SizedBox(height: 14.0),
                  Row(
                    children: [
                      if (icon != null) icon,
                      const SizedBox(
                        width: 8.0,
                      ),
                      AppIcons.clock,
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        '${lesson.duration}',
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
      ),
    );
  }
}
