import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';

class ProgressItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool nextIsLocked;
  final EducationLesson lesson;

  const ProgressItem({
    super.key,
    required this.lesson,
    required this.isLast,
    required this.isFirst,
    required this.nextIsLocked,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = !lesson.isLocked && !lesson.isCompleted;

    return Column(
      children: [
        isFirst
            ? const Expanded(
                child: SizedBox.shrink(),
              )
            : Expanded(
                child: Container(
                  width: 4,
                  color: lesson.isLocked ? AppColors.yellowLight : AppColors.darkGreen,
                ),
              ),
        lesson.isCompleted
            ? Hexagon(
                width: 30.0,
                height: 30.0,
                borderRadius: 10,
                innerWidget: Container(
                  color: AppColors.darkGreen,
                  padding: const EdgeInsets.all(10.0),
                  child: const ImageIcon(
                    AppIcons.checkmark,
                    color: AppColors.bgGreen,
                  ),
                ),
              )
            : Container(
                height: 30,
                width: 30,
                decoration: ShapeDecoration(
                  shape: PolygonBorder(
                    sides: 6,
                    rotate: 30.0,
                    borderRadius: 10,
                    side: BorderSide(color: isAvailable ? AppColors.darkGreen : AppColors.yellowLight, width: 3),
                  ),
                ),
              ),
        isLast
            ? const Expanded(
                child: SizedBox.shrink(),
              )
            : Expanded(
                child: Container(
                  width: 4,
                  color: nextIsLocked ? AppColors.yellowLight : AppColors.darkGreen,
                ),
              ),
      ],
    );
  }
}
