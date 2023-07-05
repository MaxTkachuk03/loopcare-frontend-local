import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';

class ExerciseCard extends StatelessWidget {
  final int index;
  final PhysicalProgramExercise exercise;

  const ExerciseCard({Key? key, required this.index, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = exercise.image;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 156,
          child: image != null
              ? NetworkImageWithCache(
                  url: image,
                  imageBoxFit: BoxFit.cover,
                )
              : null,
        ),
        Expanded(
          child: Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(maxLines: 2, '$index. ${exercise.name}'),
          ),
        )
      ],
    );
  }
}
