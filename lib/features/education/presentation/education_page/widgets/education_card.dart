import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_countdown.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';

class EducationCard extends StatelessWidget {
  static const _initialLessonPageIndex = 0;

  final EducationLesson lesson;
  final bool? isCategoryItem;

  const EducationCard({
    Key? key,
    required this.lesson,
    this.isCategoryItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAvailable = !lesson.isCompleted && !lesson.isLocked;
    Widget? icon = isCategoryItem ?? false
        ? const ImageIcon(
            AppIcons.iconCheckmark,
            color: AppColors.greenMid,
            size: 18,
          )
        : null;

    if (lesson.isLocked) {
      icon = const ImageIcon(
        AppIcons.iconLock,
        color: AppColors.darkGreen,
      );
    }

    if (isAvailable) {
      icon = const Image(image: AppImages.arrowHexagon);
    }

    return Row(
      children: [
        if (!(isCategoryItem ?? false))
          ClipPath(
            clipper: _TriangleClipper(),
            child: Container(
              color: lesson.isLocked ? AppColors.dirtyWhite : AppColors.white,
              height: 20,
              width: 10,
            ),
          ),
        Expanded(
          child: BlocBuilder<EducationProgramBloc, EducationProgramState>(
            builder: (BuildContext context, state) {
              final lessonWithCountdown = state.data.lessonWithCountdown;
              final isLessonWithCountDown =
                  lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id;
              final isLocked = lesson.isLocked || isLessonWithCountDown;

              return GestureDetector(
                onTap: isLocked ? null : () => _onTapHandler(context),
                child: Container(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0, left: 20.0),
                  decoration: BoxDecoration(
                    color: isLocked ? AppColors.dirtyWhite : AppColors.white,
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
                                    fontWeight: isLocked ? FontWeight.w400 : FontWeight.w700,
                                    color: isAvailable && !isLessonWithCountDown
                                        ? AppColors.orangeDark
                                        : AppColors.greyLabel,
                                  ),
                            ),
                            const SizedBox(height: 14.0),
                            Text(
                              lesson.title,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: isAvailable && !isLessonWithCountDown
                                        ? AppColors.orangeDark
                                        : AppColors.darkGreen,
                                  ),
                            ),
                            const SizedBox(height: 14.0),
                            // lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id
                            //     ? Wrap(
                            //         children: [
                            //           const Image(
                            //             image: AppImages.iconAttention,
                            //           ),
                            //           const SizedBox(
                            //             width: 6.0,
                            //           ),
                            //           Text('${LocalizedTexts.availableIn.translation}: '),
                            //           EducationCountDown(
                            //             seconds: lessonWithCountdown.timeRemaining,
                            //           ),
                            //         ],
                            //       )
                            Row(
                              children: [
                                if (icon != null)
                                  Row(
                                    children: [
                                      isLessonWithCountDown
                                          ? const ImageIcon(
                                              AppIcons.iconLock,
                                              color: AppColors.darkGreen,
                                            )
                                          : icon,
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                    ],
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _onTapHandler(BuildContext context) {
    context.read<EducationLessonBloc>().add(
          EducationLessonEvent.getLessonContent(
            lessonId: lesson.id,
            pageIndex: _initialLessonPageIndex,
          ),
        );

    context.router.pushNamed('/lesson/${lesson.id}/page/$_initialLessonPageIndex');
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height / 2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(_TriangleClipper oldClipper) => false;
}
