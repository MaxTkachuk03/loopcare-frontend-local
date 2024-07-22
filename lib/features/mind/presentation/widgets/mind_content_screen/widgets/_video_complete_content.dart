part of '../mind_content_screen.dart';

class _VideoCompleteContent extends StatelessWidget {
  const _VideoCompleteContent({
    required this.isExercise,
    required this.contentTitle,
    required this.completeButtonLabel,
    required this.onCompletePressed,
    this.techniqueTitle,
    this.minutesCounter,
    this.difficulty,
    this.onRepeatPressed,
  }) : assert(
        isExercise && techniqueTitle != null && minutesCounter != null || !isExercise,
        'Parameters {techniqueTitle} and {minutesCounter} required for {type} [_MindContentScreenType.exercise]',
      );

  final bool isExercise;
  final String completeButtonLabel;
  final String contentTitle;
  final String? techniqueTitle;
  final String? minutesCounter;
  final TechniqueExerciseDifficulty? difficulty;
  final void Function() onCompletePressed;
  final void Function()? onRepeatPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText.bitter400(
          LocalizedTexts.completedExerciseMessage1.tr(),
          style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        if (isExercise)
          CustomText.bitter400(
            LocalizedTexts.completedExerciseMessage2
                .tr(args: [techniqueTitle!])
                .toLowerCase(),
            style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          )
        else
          CustomText.bitter400(
            LocalizedTexts.completedIntroductionMessage2.tr(),
            style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 4),
        CustomText.bitter600(
          contentTitle.tr(),
          style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        if (isExercise) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.watch_later_outlined,
                color: AppColors.white,
                size: 20,
              ),
              const SizedBox(width: 6),
              CustomText.w600(
                minutesCounter!,
                style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
              ),
              const SizedBox(width: 16),
              MindDifficultyBadge(difficulty),
            ],
          ),
          const SizedBox(height: 30),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isExercise) ...[
              CustomOutlinedButton.yellow(
                label: LocalizedTexts.repeat.tr(),
                style: ButtonStyle(
                  side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (states) => states.contains(WidgetState.disabled) ? AppColors.greenLightest : AppColors.white,
                  ),
                ),
                onPressed: onRepeatPressed,
              ),
              const SizedBox(width: 16),
            ],
            CustomElevatedButton.yellow(
              label: completeButtonLabel,
              onPressed: onCompletePressed,
            ),
          ],
        ),
      ],
    );
  }
}
