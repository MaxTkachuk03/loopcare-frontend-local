import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_countdown.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';

class NextLesson extends StatelessWidget {
  final EducationLesson lesson;

  const NextLesson({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationProgramBloc, EducationProgramState>(
      builder: (context, state) {
        final lessonWithCountdown = state.data.lessonWithCountdown;
        final isLessonWithCountDown = lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id;

        return GestureDetector(
          onTap: isLessonWithCountDown ? null : () => _onTapHandler(context),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Text(
                      lesson.category.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: ThemeConstants.fontSize12,
                            fontWeight: isLessonWithCountDown ? FontWeight.w400 : FontWeight.w700,
                            color: isLessonWithCountDown ? AppColors.greyLabel : AppColors.orangeDarkWithBlack,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGreen,
                          ),
                    ),
                    const SizedBox(height: 6.0),
                    if (lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id)
                      Wrap(
                        children: [
                          const Image(
                            image: AppImages.iconAttention,
                            height: 15.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '${LocalizedTexts.availableIn.translation}: ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          EducationCountDown(
                            seconds: lessonWithCountdown.timeRemaining,
                          ),
                        ],
                      ),
                    if (lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id)
                      const SizedBox(height: 6.0),
                    Row(
                      children: [
                        isLessonWithCountDown
                            ? const ImageIcon(
                                AppIcons.iconLock,
                                color: AppColors.darkGreen,
                              )
                            : const Image(image: AppImages.arrowHexagon),
                        const SizedBox(width: 12.0),
                        AppIcons.clock,
                        const SizedBox(width: 6.0),
                        Text(
                          formatDuration(lesson.duration),
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 114.0,
                height: 98.0,
                child: SizedBox(
                  width: 144.0,
                  child: NetworkImageWithCache(url: lesson.image, alignment: Alignment.centerLeft),
                ),
              ),
            ],
          ),
        );
      },
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
