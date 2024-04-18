import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_content.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_explanation_type.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_video_complete/mind_video_complete.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_video_screen/mind_video_screen.dart';

class MindContentView extends StatefulWidget {
  const MindContentView({
    super.key,
    required this.title,
    required this.steps,
    this.onComplete,
  });

  final String title;
  final List<MindContent> steps;
  final void Function()? onComplete;

  @override
  State<MindContentView> createState() => _MindContentViewState();
}

class _MindContentViewState extends State<MindContentView> {
  late List<MindContent> steps;
  int currentStepIndex = 0;
  bool isCompleted = false;

  void onStepComplete() {
    if ((currentStepIndex + 1) >= steps.length) {
      isCompleted = true;
      widget.onComplete?.call();
    } else {
      currentStepIndex++;
    }

    setState(() {});
  }

  void onRepeat() {
    currentStepIndex = 0;
    isCompleted = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    steps = widget.steps;
  }

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return MindVideoComplete(
        onCompletePressed: context.router.pop,
        onRepeatPressed: onRepeat,
      );
    }

    final currentStep = steps[currentStepIndex];

    return switch (currentStep.type) {
      TechniqueExplanationType.video => MindVideoScreen(
        title: widget.title,
        url: currentStep.src,
        onCompleted: onStepComplete,
      ),
      TechniqueExplanationType.text => Container(),
    };
  }
}
