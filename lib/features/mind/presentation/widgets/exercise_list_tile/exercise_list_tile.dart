import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique_exercise.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_difficulty_badge/mind_difficulty_badge.dart';

class ExerciseListTile extends StatelessWidget {
  const ExerciseListTile({
    super.key,
    required this.exercise,
  });

  final MindTechniqueExercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 212.0,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.fromBorderSide(
          BorderSide(
            color: AppColors.petrolLighter,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: ImageClipper(),
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(8),
              ),
              child: SizedBox(
                width: 150.0,
                child: NetworkImageWithCache(
                  url: exercise.image,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.bitter600(
                  exercise.title,
                  style: context.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                CustomText.w400(
                  exercise.shortDescription,
                  style: context.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    MindDifficultyBadge(exercise.difficulty),
                    const SizedBox(width: 16),
                    const Icon(Icons.watch_later_outlined, size: 20),
                    const SizedBox(width: 6),
                    CustomText.w600(
                      LocalizedTexts.countMins.tr(
                        args: [Duration(seconds: exercise.stepsDuration).inMinutes.toString()],
                      ),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (exercise.explanation != null) ...[
                      CustomElevatedButton.yellowSmall(
                        label: LocalizedTexts.intro.tr(),
                        onPressed: () => context
                          ..read<MindBloc>().add(MindEvent.selectExercise(exercise: exercise))
                          ..router.pushNamed(AppRoutes.mindIntroExercise),
                      ),
                      const SizedBox(width: 16),
                    ],
                    CustomElevatedButton.yellowSmall(
                      label: LocalizedTexts.start.tr(),
                      onPressed: () => context
                        ..read<MindBloc>().add(MindEvent.selectExercise(exercise: exercise))
                        ..router.pushNamed(AppRoutes.mindExercise),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
