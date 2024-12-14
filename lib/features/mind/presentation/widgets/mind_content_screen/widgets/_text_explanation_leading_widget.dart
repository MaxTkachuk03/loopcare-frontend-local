part of '../mind_content_screen.dart';

class _TextExplanationLeadingWidget extends StatelessWidget {
  const _TextExplanationLeadingWidget({
    super.key,
    required this.type,
    required this.url,
    this.exercise,
  });

  final _MindContentScreenType type;
  final String? url;
  final MindTechniqueExercise? exercise;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      _MindContentScreenType.exercise => const SizedBox.shrink(),
      _MindContentScreenType.intro => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText.bitter600(
              LocalizedTexts.selectedExercise.tr(),
              style: context.textTheme.bodyLarge?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 20),
            ExerciseListTile(
              exercise: exercise!,
              hideIntro: true,
            ),
            const SizedBox(height: 8),
            CustomText.bitter600(
              exercise?.explanation?.title ?? '',
              style: context.textTheme.bodyLarge?.copyWith(color: AppColors.white),
            ),
          ],
        ),
      _MindContentScreenType.explanation => url != null
          ? SizedBox(height: 276, child: NetworkImageWithCache(url: url!))
          : const SizedBox.shrink(),
    };
  }
}
