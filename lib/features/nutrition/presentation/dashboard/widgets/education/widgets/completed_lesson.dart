import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';

class CompletedLesson extends StatelessWidget {
  final EducationLesson lesson;

  const CompletedLesson({Key? key, required this.lesson}) : super(key: key);

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
              color: AppColors.greenMid,
              size: 14,
            ),
          ),
          const SizedBox(width: 14.0,),
          Expanded(
            child: Text(
              lesson.title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(width: 14.0,),
          const ImageIcon(
            AppIcons.arrow,
            color: AppColors.greyLabel,
          ),
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

    context.router
        .pushNamed('/lesson/${lesson.id}/page/0');
  }
}
