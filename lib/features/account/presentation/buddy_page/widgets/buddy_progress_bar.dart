import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_questions.dart';

class BuddyProgressBar extends StatelessWidget {
  final Color backgroundColor;
  final Color? progressFillColor;
  final Color? progressEmptyColor;

  const BuddyProgressBar({
    super.key,
    required this.backgroundColor,
    this.progressFillColor,
    this.progressEmptyColor,
  });

  factory BuddyProgressBar.coral({required Color backgroundColor}) => BuddyProgressBar(
        backgroundColor: backgroundColor,
        progressFillColor: AppColors.coralRegular,
        progressEmptyColor: AppColors.blueLighter,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuddyBloc, BuddyState>(
      builder: (BuildContext context, BuddyState state) {
        final stepsLength = BuddyQuestions.values.length - 1;
        List<Widget> stepsList = [];
        for (var i = 0; i < stepsLength; i++) {
          final value = i < state.data.currentQuestion.index ? 100 : 0;

          stepsList.add(
            Flexible(
              child: _Item(
                progress: state.data.currentQuestion.index == i ? state.data.currentStepProgress : value,
                progressFillColor: progressFillColor ?? AppColors.blueDarker,
                progressEmptyColor: progressEmptyColor ?? AppColors.blueLighter,
              ),
            ),
          );
        }

        return Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12.0),
          child: Row(children: stepsList),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final Color progressFillColor;
  final Color progressEmptyColor;
  final int progress;

  const _Item({required this.progress, required this.progressFillColor, required this.progressEmptyColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(height: 4, color: progressEmptyColor),
              SizedBox(
                height: 4,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: 4,
                      width: constraints.maxWidth * progress / 100,
                      color: progressFillColor,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(radius: 10, backgroundColor: progress == 100 ? progressFillColor : progressEmptyColor)
      ],
    );
  }
}
