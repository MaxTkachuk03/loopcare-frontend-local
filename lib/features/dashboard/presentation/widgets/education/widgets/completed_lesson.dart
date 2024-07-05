import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';

class CompletedLesson extends StatelessWidget {
  final EducationLesson lesson;

  const CompletedLesson({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapHandler(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
            child: ImageIcon(
              AppIcons.iconCheckmark,
              color: AppColors.greenRegular,
              size: 14,
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: CustomText.w600(
              lesson.title,
              style: context.textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: 14.0),
          const ImageIcon(
            AppIcons.arrow,
            color: AppColors.blueDarker,
          ),
        ],
      ),
    );
  }

  _onTapHandler(BuildContext context) {
    context
        .read<EducationLessonBloc>()
        .add(EducationLessonEvent.getLessonContent(lessonId: lesson.id));

    context.router.pushNamed('/lesson/${lesson.id}');
  }
}
