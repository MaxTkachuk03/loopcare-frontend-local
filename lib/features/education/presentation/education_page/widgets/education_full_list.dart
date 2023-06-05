import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/progress_item.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_card.dart';

class EducationFullList extends StatelessWidget {
  final List<EducationLesson> lessons;

  const EducationFullList({Key? key, required this.lessons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (BuildContext context, index) {
        final isLastElement = index + 1 == lessons.length;
        final isFirstElement = index == 0;
        final nextIsLocked = isLastElement ? true : lessons[index + 1].isLocked;

        return IntrinsicHeight(
          child: Row(
            children: [
              ProgressItem(
                isFirst: isFirstElement,
                isLast: isLastElement,
                lesson: lessons[index],
                nextIsLocked: nextIsLocked,
              ),
              const SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 6.0,
                    ),
                    EducationCard(
                      lesson: lessons[index],
                      isCategoryItem: false,
                    ),
                    const SizedBox(
                      height: 6.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
