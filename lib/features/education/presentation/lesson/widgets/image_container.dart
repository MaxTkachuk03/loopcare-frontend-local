import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/subtitle/image_subtitle_controller.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/image_subtitles.dart';

class ImageContainer extends StatelessWidget {
  final SubtitleController controller;
  final double height;

  const ImageContainer({
    super.key,
    required this.controller,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isPlaying,
      builder: (context, isPlaying, _) {
        return BlocBuilder<EducationLessonBloc, EducationLessonState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: isPlaying ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                      height: height, child: NetworkImageWithCache(url: state.data.imageUrl)),
                ),
                if (state.data.subtitleFilePath.isNotEmpty)
                  AnimatedOpacity(
                    opacity: isPlaying ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      height: height,
                      child: ImageSubtitles(controller: controller),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
