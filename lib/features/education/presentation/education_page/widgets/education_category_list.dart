import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_card.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EducationCategoryList extends StatefulWidget {
  final List<EducationLesson> lessons;

  const EducationCategoryList({Key? key, required this.lessons})
      : super(key: key);

  @override
  State<EducationCategoryList> createState() => _EducationCategoryListState();
}

class _EducationCategoryListState extends State<EducationCategoryList> with WidgetsBindingObserver {
  final ItemScrollController _controller = ItemScrollController();

  @override
  void initState() {
    super.initState();

    _jumpToActiveLesson();
  }

  void _jumpToActiveLesson() {
    final dataState = context.read<EducationProgramBloc>().state.data;
    final activeLessonIndex = dataState.activeLessonIndex;
    final lessonWithCountdown = dataState.lessonWithCountdown;

    if (lessonWithCountdown == null && activeLessonIndex > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.jumpTo(index: activeLessonIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _controller,
      itemCount: widget.lessons.length,
      itemBuilder: (BuildContext context, index) {
        return IntrinsicHeight(
          child: Column(
            children: [
              EducationCard(
                lesson: widget.lessons[index],
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
