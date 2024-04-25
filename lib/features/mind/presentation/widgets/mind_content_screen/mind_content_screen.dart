import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_content.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_exercise_difficulty.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_explanation_type.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/exercise_list_tile/exercise_list_tile.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_difficulty_badge/mind_difficulty_badge.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_text_screen/mind_text_screen.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_video_screen/mind_video_screen.dart';

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
  }) : onComplete = null,
        url = null,
        _type = _MindContentScreenType.exercise;

  const MindContentScreen.intro({
    super.key,
    required this.title,
    required this.steps,
    required this.contentTitle,
    required this.onComplete,
  }) : onExerciseCompleted = null,
        onRepeat = null,
        url = null,
        difficulty = null,
        _type = _MindContentScreenType.intro;

  const MindContentScreen.explanation({
    super.key,
    required this.title,
    required this.steps,
    required this.onComplete,
    required this.contentTitle,
    required this.url,
  }) : onExerciseCompleted = null,
        onRepeat = null,
        difficulty = null,
        _type = _MindContentScreenType.explanation;

  final String title;
  final String? url;
  final List<MindContent> steps;
  final void Function()? onExerciseCompleted;
  final void Function()? onRepeat;
  final void Function()? onComplete;
  final _MindContentScreenType _type;
  final String contentTitle;
  final TechniqueExerciseDifficulty? difficulty;

  @override
  State<MindContentScreen> createState() => _MindContentScreenState();
}

class _MindContentScreenState extends State<MindContentScreen> {
  late List<MindContent> steps;
  int currentStepIndex = 0;
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

    if ((currentStepIndex + 1) >= steps.length) {
      isCompleted = true;
      widget.onExerciseCompleted?.call();
    } else {
      currentStepIndex++;
    }

    setState(() {});
  }

  void onRepeat() {
    currentStepIndex = 0;
    isCompleted = false;

    widget.onRepeat?.call();

    setState(() {});
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

  @override
  void initState() {
    super.initState();
    steps = widget.steps;
  }

  @override
  Widget build(BuildContext context) {
    final duration = Duration(seconds: steps.map((e) => e.duration ?? 0).sum).inMinutes.toString();

    final currentStep = steps[currentStepIndex];

    final skipButtonLabel = _type.isIntro ? LocalizedTexts.skipIntro.tr() : LocalizedTexts.skipExplanation.tr();

    final completesWidget = _VideoCompleteContent(
      contentTitle: widget.contentTitle,
      isExercise: _type.isExercise,
      completeButtonLabel: _buttonLabel,
      difficulty: widget.difficulty,
      minutesCounter: duration,
      techniqueTitle: widget.title,
      onRepeatPressed: _type.isExercise ? onRepeat : null,
      onCompletePressed: widget.onComplete ?? context.router.pop,
    );

    if (isCompleted) {
      return CustomScaffold.petrol(
        appBar: CustomAppBar.petrol(
          title: widget.title,
          leading: CustomFilledIconButton.leadingPetrolLighter(),
        ),
        body: CustomSafeArea(
          child: completesWidget,
        ),
      );
    }

    return switch (currentStep.type) {
      TechniqueExplanationType.video => MindVideoScreen(
        title: widget.title,
        url: currentStep.src,
        onCompleted: onStepComplete,
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
          type: _type,
          url: widget.url,
        ),
      ),
    };
  }
}
