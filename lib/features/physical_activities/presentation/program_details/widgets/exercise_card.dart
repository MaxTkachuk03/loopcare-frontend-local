import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';

class ExerciseCard extends StatelessWidget {
  final int index;
  final PhysicalProgramExercise exercise;

  const ExerciseCard({super.key, required this.index, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final image = exercise.image;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          const SizedBox(
            width: 16.0,
          ),
          SizedBox(
            width: 26,
            height: 26,
            child: CircleAvatar(
              backgroundColor: AppColors.blueDarker,
              child: CustomText.w400(
                '${index + 1}',
                style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          SizedBox(
            height: 46,
            width: 49,
            child: image != null
                ? NetworkImageWithCache(
                    url: image,
                    imageBoxFit: BoxFit.cover,
                  )
                : null,
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: CustomText.w500(
              exercise.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall,
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
        ],
      ),
    );
  }
}
