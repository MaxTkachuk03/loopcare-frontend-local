part of '../mind_content_screen.dart';

class _TextExplanationLeadingWidget extends StatelessWidget {
  const _TextExplanationLeadingWidget({
    super.key,
    required this.type,
    required this.url,
  });

  final _MindContentScreenType type;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final mindData = context.read<MindBloc>().state.data;

    return switch(type) {
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
            exercise: mindData.currentExerciseWithoutIntro,
          ),
          const SizedBox(height: 8),
          CustomText.bitter600(
            mindData.currentExercise?.explanation?.title ?? '',
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
