import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class LessonImageHeader extends StatelessWidget {
  const LessonImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationLessonBloc, EducationLessonState>(
      builder: (context, state) {
        final lesson = state.data;

        return SizedBox(height: 365, child: NetworkImageWithCache(url: lesson.imageUrl));
      },
    );
  }
}
