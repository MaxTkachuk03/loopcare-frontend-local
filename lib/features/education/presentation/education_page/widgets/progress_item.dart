import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
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
            ? const Expanded(child: SizedBox.shrink())
            : Expanded(
                child: Container(
                  width: lesson.isLocked ? 4 : 6,
                  color: lesson.isLocked ? AppColors.petrolLighter : AppColors.coralRegular,
                ),
              ),
        CircleAvatar(
          radius: 10,
          backgroundColor:
              lesson.isCompleted || isAvailable ? AppColors.coralRegular : AppColors.petrolLighter,
        ),
        isLast
            ? const Expanded(child: SizedBox.shrink())
            : Expanded(
                child: Container(
                  width: nextIsLocked ? 4 : 6,
                  color: nextIsLocked ? AppColors.petrolLighter : AppColors.coralRegular,
                ),
              ),
      ],
    );
  }
}
