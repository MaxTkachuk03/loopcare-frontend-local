import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_content.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique_exercise.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_exercise_difficulty.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_explanation_type.dart';
import 'package:loopcare_frontend/features/mind/application/ui_models/mind_exercise_step.dart';
import 'package:loopcare_frontend/features/mind/domain/mind_utils.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/exercise_list_tile/exercise_list_tile.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_difficulty_badge/mind_difficulty_badge.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_rating_screen/mind_rating_screen.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_text_screen/mind_text_screen.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_video_screen/mind_video_screen.dart';

part 'widgets/_completed_exercise_screen.dart';
part 'widgets/_mind_content_screen_type.dart';
part 'widgets/_text_explanation_leading_widget.dart';
part 'widgets/_video_complete_content.dart';

class MindContentScreen extends StatefulWidget {
  const MindContentScreen.exercise({
    super.key,
    required this.title,
    required this.steps,
    required this.contentTitle,
    required this.difficulty,
    required this.onExerciseCompleted,
    required this.onRepeat,
    required this.stepIndex,
  }) : onComplete = null,
        exercise = null,
        _type = _MindContentScreenType.exercise;

  const MindContentScreen.intro({
    super.key,
    required this.title,
    required this.steps,
    required this.contentTitle,
    required this.exercise,
    required this.onComplete,
  }) : onExerciseCompleted = null,
        stepIndex = 1,
        onRepeat = null,
        difficulty = null,
        _type = _MindContentScreenType.intro;

  const MindContentScreen.explanation({
    super.key,
    required this.title,
    required this.steps,
    required this.onComplete,
    required this.contentTitle,
  }) : onExerciseCompleted = null,
        stepIndex = 1,
        onRepeat = null,
        exercise = null,
        difficulty = null,
        _type = _MindContentScreenType.explanation;

  final String title;
  final List<MindContent> steps;
  final void Function()? onExerciseCompleted;
  final void Function()? onRepeat;
  final void Function()? onComplete;
  final _MindContentScreenType _type;
  final String contentTitle;
  final int stepIndex;
  final TechniqueExerciseDifficulty? difficulty;
  final MindTechniqueExercise? exercise;

  @override
  State<MindContentScreen> createState() => _MindContentScreenState();
}

class _MindContentScreenState extends State<MindContentScreen> {
  late List<MindContent> steps;
  bool isCompleted = false;

  _MindContentScreenType get _type => widget._type;

  String get _buttonLabel {
    if (widget.title == LocalizedTexts.mindTraining.tr()) {
      return LocalizedTexts.chooseTechnique.tr();
    }

    return switch (_type) {
      _MindContentScreenType.exercise => LocalizedTexts.ok.tr().capitalize(),
      _MindContentScreenType.intro => LocalizedTexts.start.tr(),
      _MindContentScreenType.explanation => LocalizedTexts.chooseExercise.tr(),
    };
  }

  void onStepComplete() {
    if (!_type.isExercise) {
      return;
    }

    context.router.push(ExerciseRoute(step: widget.stepIndex + 1));

    setState(() {});
  }

  void onRepeat() {
    context.router.push(ExerciseRoute());
    widget.onRepeat?.call();
  }

  RichText _getContentTitle() {
    return RichText(
      text: TextSpan(
        children: [
          if (!_type.isExercise) ...[
            TextSpan(
              text: LocalizedTexts.introduction.tr(),
              style: context.textTheme.displayMedium?.copyWith(
                fontFamily: ThemeConstants.bitterFontFamily,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            const TextSpan(
              text: '\n',
            ),
          ],
          TextSpan(
            text: widget.contentTitle,
            style: context.textTheme.displayMedium?.copyWith(
              fontFamily: ThemeConstants.bitterFontFamily,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _defaultCompletion() =>
      context.router.popUntilRouteWithName(TechniqueExercisesRoute.name);

  @override
  void initState() {
    super.initState();
    steps = widget.steps;

    isCompleted = widget.stepIndex > steps.length;

    if (isCompleted) {
      widget.onExerciseCompleted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = steps.map((e) => e.duration ?? 0).sum;

    final completesWidget = _VideoCompleteContent(
      contentTitle: widget.contentTitle,
      isExercise: _type.isExercise,
      completeButtonLabel: _buttonLabel,
      difficulty: widget.difficulty,
      minutesCounter: MindUtils.getDurationLine(duration),
      techniqueTitle: widget.title,
      onRepeatPressed: _type.isExercise ? onRepeat : null,
      onCompletePressed: widget.onComplete ?? _defaultCompletion,
    );

    if (isCompleted) {
      return _CompletedExerciseScreen(
        key: const ValueKey('completed_exercise_screen'),
        title: widget.title,
        child: completesWidget,
      );
    }

    final currentStep = steps[widget.stepIndex - 1];
    final skipButtonLabel = _type.isIntro ? LocalizedTexts.skipIntro.tr() : LocalizedTexts.skipExplanation.tr();

    return switch (currentStep.type) {
      TechniqueExplanationType.video => MindVideoScreen(
        title: widget.title,
        url: currentStep.src,
        onCompleted: onStepComplete,
        videoOrientation: (currentStep.orientation?.isPortrait ?? false) ? Orientation.portrait : Orientation.landscape,
        onSkip: widget.onComplete,
        skipButtonLabel: skipButtonLabel,
        contentTitle: _getContentTitle(),
        onCompleteOverlay: !_type.isExercise ? completesWidget : null,
      ),
      TechniqueExplanationType.text => MindTextScreen(
        title: widget.title,
        url: currentStep.src,
        buttonLabel: _buttonLabel,
        onCompleted: widget.onComplete,
        backgroundBrightness: _type.isIntro ? Brightness.dark : Brightness.light,
        leading: _TextExplanationLeadingWidget(
          key: const ValueKey('headline_explanation_widget'),
          type: _type,
          url: currentStep.image,
          exercise: widget.exercise,
        ),
      ),
      TechniqueExplanationType.rating => MindRatingScreen(
        title: widget.title,
        question: (currentStep as MindExerciseStep).src,
        lowestText: currentStep.lowestText,
        highestText: currentStep.highestText,
        isFinish: widget.stepIndex == steps.length,
        onCompleted: onStepComplete,
      ),
    };
  }
}
