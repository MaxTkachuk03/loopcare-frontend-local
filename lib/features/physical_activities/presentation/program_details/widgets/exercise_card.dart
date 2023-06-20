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
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0, bottom: 32.0),
            child: Text('$index. ${exercise.name}'),
          ),
        )
      ],
    );
  }
}
