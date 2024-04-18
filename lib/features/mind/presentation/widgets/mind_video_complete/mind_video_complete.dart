import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_difficulty_badge/mind_difficulty_badge.dart';

class MindVideoComplete extends StatelessWidget {
  const MindVideoComplete({
    super.key,
    required this.onCompletePressed,
    this.onRepeatPressed,
    this.completeButtonLabel = LocalizedTexts.ok,
  });

  final String completeButtonLabel;
  final void Function() onCompletePressed;
  final void Function()? onRepeatPressed;

  @override
  Widget build(BuildContext context) {
    final state = context.read<MindBloc>().state;
    final title = state.data.currentTechnique?.title ?? '';
    final exerciseTitle = state.data.currentExercise?.title ?? '';
    final exerciseTime = state.data.currentExercise?.stepsDuration ?? 0;
    final exerciseDifficulty = state.data.currentExercise?.difficulty;

    return CustomScaffold.petrol(
      appBar: CustomAppBar.petrol(
        title: title,
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: CustomSafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText.bitter400(
              'Great! You completed',
              style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 4),
            CustomText.bitter400(
              '${title.toLowerCase()} exercise',
              style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 4),
            CustomText.bitter600(
              exerciseTitle,
              style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 30),
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
                  LocalizedTexts.countMins.tr(
                    args: [Duration(seconds: exerciseTime).inMinutes.toString()],
                  ),
                  style: context.textTheme.bodySmall?.copyWith(color: AppColors.white),
                ),
                const SizedBox(width: 16),
                MindDifficultyBadge(exerciseDifficulty),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOutlinedButton.yellow(
                  label: LocalizedTexts.repeat.tr(),
                  style: ButtonStyle(
                    side: ButtonStyles.getButtonBorder(ButtonStyles.borderYellow),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) =>
                      states.contains(MaterialState.disabled) ? AppColors.greenLightest : AppColors.white,
                    )
                  ),
                  onPressed: onRepeatPressed,
                ),
                const SizedBox(width: 16),
                CustomElevatedButton.yellow(
                  label: completeButtonLabel.tr().capitalize(),
                  onPressed: onCompletePressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
