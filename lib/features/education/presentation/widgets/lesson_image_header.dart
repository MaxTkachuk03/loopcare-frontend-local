import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/oval_bottom_border_clipper.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class LessonImageHeader extends StatelessWidget {
  const LessonImageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationLessonBloc, EducationLessonState>(
      builder: (context, state) {
        final lesson = state.data;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 90,
                width: double.infinity,
                color: AppColors.white,
              ),
            ),
            Positioned(
              bottom: -95,
              left: 1,
              right: 1,
              child: SizedBox(
                width: 234,
                height: 182,
                child: NetworkImageWithCache(url: lesson.lessonImage),
              ),
            ),
          ],
        );
      },
    );
  }
}
