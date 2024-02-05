import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/time_service/time_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/utils/get_label_by_category.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_countdown.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/lesson_state.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';

class EducationCard extends StatelessWidget {
  static const _initialLessonPageIndex = 0;

  final EducationLesson lesson;

  const EducationCard({super.key, required this.lesson});

  Widget _getLessonAction(BuildContext context) {
    final isAvailable = !lesson.isCompleted && !lesson.isLocked;

    if (lesson.isLocked) {
      return Row(
        children: [
          LessonState.locked(),
          const SizedBox(width: 4.0),
          CustomText.w700(LocalizedTexts.locked, style: context.textTheme.bodySmall),
        ],
      );
    }

    if (isAvailable) {
      return CustomOutlinedButton.orangeSmall(
        label: LocalizedTexts.start,
        onPressed: () => _onTapHandler(context),
      );
    }

    return Row(
      children: [
        LessonState.completed(),
        const SizedBox(width: 4.0),
        CustomText.w700(LocalizedTexts.completed, style: context.textTheme.bodySmall),
      ],
    );
  }

  _onTapHandler(BuildContext context) {
    context
        .read<EducationLessonBloc>()
        .add(EducationLessonEvent.getLessonContent(lessonId: lesson.id, pageIndex: _initialLessonPageIndex));

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

              final showCountdown = lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id;

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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getLabelByCategory(lesson.category),
                                const SizedBox(height: 10.0),
                                CustomText.bitter700(
                                  lesson.title,
                                  style: context.textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    const Icon(Icons.watch_later_outlined, size: 16),
                                    const SizedBox(width: 6.0),
                                    CustomText.w600(
                                      formatDuration(lesson.duration),
                                      style: context.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                SizedBox(height: showCountdown ? 0 : 10.0),
                                _getLessonAction(context),
                                SizedBox(height: showCountdown ? 0 : 10.0),
                                if (showCountdown)
                                  Wrap(
                                    children: [
                                      CustomText.w600(
                                        '${LocalizedTexts.availableIn.tr()}: ',
                                        style: context.textTheme.bodySmall,
                                      ),
                                      FutureBuilder<DateTime>(
                                        future: TimeService.now,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data;

                                          if (snapshot.hasData && data != null) {
                                            return EducationCountDown(
                                                seconds: lessonWithCountdown.dateTimeWhenUnlock
                                                    .difference(data)
                                                    .inSeconds);
                                          } else {
                                            return const Text('');
                                          }
                                        },
                                      )
                                    ],
                                  ),
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
