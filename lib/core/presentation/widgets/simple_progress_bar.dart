import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SimpleProgressBar extends StatelessWidget {
  final int progress;
  final Color? backgroundColor;
  final Color? progressFillColor;
  final Color? progressEmptyColor;

  const SimpleProgressBar({
    super.key,
    required this.progress,
    this.backgroundColor,
    this.progressFillColor,
    this.progressEmptyColor,
  });

  factory SimpleProgressBar.petrol({int? progress}) => SimpleProgressBar(
        backgroundColor: AppColors.petrolRegular,
        progressFillColor: AppColors.greenRegular,
        progressEmptyColor: AppColors.petrolLightest,
        progress: progress ?? 100,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12.0),
      child: Row(
        children: [
          CircleAvatar(radius: 10, backgroundColor: progressFillColor),
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
          CircleAvatar(radius: 10, backgroundColor: progressEmptyColor),
        ],
      ),
    );
  }
}
