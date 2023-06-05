import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_card.dart';

class EducationCategoryList extends StatelessWidget {
  final List<EducationLesson> lessons;

  const EducationCategoryList({Key? key, required this.lessons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (BuildContext context, index) {
        return IntrinsicHeight(
          child: Column(
            children: [
              EducationCard(
                lesson: lessons[index],
                isCategoryItem: true,
              ),
              const SizedBox(
                height: 12.0,
              )
            ],
          ),
        );
      },
    );
  }
}
