import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ProgressBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color? progressFillColor;
  final Color progressEmptyColor;
  final int segments;
  final int value;
  final int progress;

  const ProgressBar({
    super.key,
    required this.backgroundColor,
    required this.segments,
    required this.value,
    required this.progress,
    this.progressFillColor,
    this.progressEmptyColor = AppColors.white,
  });

  factory ProgressBar.coral({
    required Color backgroundColor,
    required int segments,
    required int value,
    required int progress,
  }) =>
      ProgressBar(
        backgroundColor: backgroundColor,
        segments: segments,
        value: value,
        progress: progress,
        progressFillColor: AppColors.coralRegular,
      );

  factory ProgressBar.orange({
    required Color backgroundColor,
    required int segments,
    required int value,
    required int progress,
  }) =>
      ProgressBar(
        backgroundColor: backgroundColor,
        segments: segments,
        value: value,
        progress: progress,
        progressFillColor: AppColors.orangeRegular,
      );

  factory ProgressBar.yellow({
    required Color backgroundColor,
    required int segments,
    required int value,
    required int progress,
  }) =>
      ProgressBar(
        backgroundColor: backgroundColor,
        segments: segments,
        value: value,
        progress: progress,
        progressFillColor: AppColors.yellowRegular,
      );

  factory ProgressBar.green({
    required Color backgroundColor,
    required int segments,
    required int value,
    required int progress,
  }) =>
      ProgressBar(
        backgroundColor: backgroundColor,
        segments: segments,
        value: value,
        progress: progress,
        progressFillColor: AppColors.greenRegular,
      );

  factory ProgressBar.petrol({
    required Color backgroundColor,
    required int segments,
    required int value,
    required int progress,
  }) =>
      ProgressBar(
        backgroundColor: backgroundColor,
        segments: segments,
        value: value,
        progress: progress,
        progressFillColor: AppColors.petrolRegular,
      );

  factory ProgressBar.blue({
    required Color backgroundColor,
    required int segments,
    required int value,
    required int progress,
  }) =>
      ProgressBar(
        backgroundColor: backgroundColor,
        segments: segments,
        value: value,
        progress: progress,
        progressFillColor: AppColors.blueRegular,
      );

  @override
  Widget build(BuildContext context) {
    List<Widget> stepsList = [];

    for (var i = 0; i < segments; i++) {
      int itemProgress = 0;

      if (i < value) {
        itemProgress = 100;
      } else if (i == value) {
        itemProgress = progress;
      }

      stepsList.add(
        Flexible(
          child: _Item(
            key: ValueKey('segments_$i'),
            progress: itemProgress,
            fillColor: progressFillColor ?? AppColors.blueDarker,
            emptyColor: progressEmptyColor,
          ),
        ),
      );
    }

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12.0),
      child: Row(children: stepsList),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    required this.progress,
    required this.fillColor,
    required this.emptyColor,
  });

  final Color fillColor;
  final Color emptyColor;
  final int progress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            ColoredBox(
              color: fillColor,
              child: SizedBox(
                height: 4,
                width: (constraints.maxWidth - 10) * progress / 100,
              ),
            ),
            if (progress < 100)
              Expanded(
                child: ColoredBox(
                  color: emptyColor,
                  child: const SizedBox(height: 4),
                ),
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: progress == 100 ? fillColor : emptyColor),
              child: const SizedBox.square(dimension: 10),
            ),
          ],
        );
      },
    );
  }
}
