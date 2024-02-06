import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/time_service/time_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
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
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';

class NextLesson extends StatelessWidget {
  final EducationLesson lesson;

  const NextLesson({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationProgramBloc, EducationProgramState>(
      builder: (context, state) {
        final lessonWithCountdown = state.data.lessonWithCountdown;

        final isLessonWithCountDown =
            lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id;

        return GestureDetector(
          onTap: isLessonWithCountDown ? null : () => _onTapHandler(context),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.blueLighter,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
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
                      height: 180,
                      child: NetworkImageWithCache(url: lesson.cardImage),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                      bottom: 6.0,
                      right: 6.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        getLabelByCategory(lesson.category),
                        const SizedBox(height: 10.0),
                        CustomText.bitter700(
                          lesson.title,
                          style: context.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 10.0),
                        if (lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id)
                          Wrap(
                            children: [
                              CustomText.w600(
                                '${LocalizedTexts.availableIn.translation}: ',
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
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            AppIcons.clock,
                            const SizedBox(width: 6.0),
                            CustomText.w600(
                              formatDuration(lesson.duration),
                              style: context.textTheme.bodySmall,
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        CustomOutlinedButton.coral(
                          label: LocalizedTexts.start.translation,
                          onPressed: isLessonWithCountDown ? null : () => _onTapHandler(context),
                        )
                      ],
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
