import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
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

class NextLesson extends StatelessWidget {
  final EducationLesson lesson;

  const NextLesson({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationProgramBloc, EducationProgramState>(
      buildWhen: (prev, cur) => cur is EducationProgramStateLoaded,
      builder: (context, state) {
        final lessonWithCountdown = state.data.lessonWithCountdown;
        final isBlocked = lessonWithCountdown != null && lesson.id == lessonWithCountdown.lesson.id;
        final isLocked = lesson.isLocked;

        return GestureDetector(
          onTap: isBlocked ? null : () => _onTapHandler(context),
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
                      height: 200,
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
                        state.maybeMap(
                            initial: (_) => const Loader(),
                            loading: (_) => const Loader(),
                            orElse: () => !isLocked && !isBlocked
                                ? CustomOutlinedButton.coralSmall(
                                    label: LocalizedTexts.start.tr(),
                                    onPressed: isBlocked ? null : () => _onTapHandler(context),
                                  )
                                : Row(
                                    children: [
                                      LessonState.locked(),
                                      const SizedBox(width: 4.0),
                                      isBlocked
                                          ? Expanded(
                                              child: Wrap(
                                                children: [
                                                  CustomText.w600(
                                                    '${LocalizedTexts.availableIn.tr()}: ',
                                                    style: context.textTheme.bodySmall,
                                                  ),
                                                  EducationCountDown(
                                                    seconds: lessonWithCountdown.timeRemaining,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : CustomText.w700(LocalizedTexts.locked,
                                              style: context.textTheme.bodySmall),
                                    ],
                                  )),
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
