import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/utils/get_label_by_category.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_countdown.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/lesson_state.dart';

class EducationCard extends StatelessWidget {
  static const _initialLessonPageIndex = 0;

  final EducationLesson lesson;

  const EducationCard({super.key, required this.lesson});

  Widget _getLessonAction(BuildContext context) {
    final isAvailable = !lesson.isCompleted && !lesson.isLocked;
    final lessonWithCountdown = context.read<EducationProgramBloc>().state.data.lessonWithCountdown;
    final showCountdown = lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id;

    if (lesson.isLocked || showCountdown) {
      return Row(
        children: [
          LessonState.locked(),
          const SizedBox(width: 6.0),
          if (!showCountdown) CustomText.w700(LocalizedTexts.locked.tr(), style: context.textTheme.bodySmall),
          if (showCountdown)
            Expanded(
              child: Wrap(
                children: [
                  CustomText.w600('${LocalizedTexts.availableIn.tr()}: ', style: context.textTheme.bodySmall),
                  EducationCountDown(seconds: lessonWithCountdown.timeRemaining),
                ],
              ),
            )
        ],
      );
    }

    if (isAvailable) {
      return CustomOutlinedButton.orangeSmall(
        label: LocalizedTexts.start.tr(),
        onPressed: () => _onTapHandler(context),
      );
    }

    return Row(
      children: [
        LessonState.completed(),
        const SizedBox(width: 4.0),
        CustomText.w700(LocalizedTexts.completed.tr(), style: context.textTheme.bodySmall),
      ],
    );
  }

  _onTapHandler(BuildContext context) {
    context
        .read<EducationLessonBloc>()
        .add(EducationLessonEvent.getLessonContent(lessonId: lesson.id, pageIndex: _initialLessonPageIndex));
    CustomerIoService.track(
      event: CIOEvents.educationArticleOpen,
      attributes: {
        CIOAttributes.articleId: lesson.id,
        CIOAttributes.articleTitle: lesson.title,
      },
    );
    context.router.pushNamed('/lesson/${lesson.id}/page/$_initialLessonPageIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Stack(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipPath(
                            clipper: ImageClipper(),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              child: SizedBox(
                                width: 130.0,
                                child: NetworkImageWithCache(url: lesson.cardImage),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getLabelByCategory(lesson.category),
                                const SizedBox(height: 8.0),
                                CustomText.bitter700(
                                  lesson.title,
                                  style: context.textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(Icons.watch_later_outlined, size: 16),
                                    const SizedBox(width: 6.0),
                                    CustomText.w600(
                                      formatSecondsToDurationString(lesson.duration, alwaysShowSeconds: true),
                                      style: context.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                _getLessonAction(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isLocked) Container(color: AppColors.white.withOpacity(0.5)),
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
