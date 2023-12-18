import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_card.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/progress_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EducationFullList extends StatefulWidget {
  final List<EducationLesson> lessons;

  const EducationFullList({super.key, required this.lessons});

  @override
  State<EducationFullList> createState() => _EducationFullListState();
}

class _EducationFullListState extends State<EducationFullList> with WidgetsBindingObserver {
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
      itemCount: widget.lessons.length,
      itemScrollController: _controller,
      itemBuilder: (_, index) {
        final isLastElement = index + 1 == widget.lessons.length;
        final isFirstElement = index == 0;
        final nextIsLocked = isLastElement ? true : widget.lessons[index + 1].isLocked;

        return IntrinsicHeight(
          child: Row(
            children: [
              ProgressItem(
                isFirst: isFirstElement,
                isLast: isLastElement,
                lesson: widget.lessons[index],
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
                    EducationCard(lesson: widget.lessons[index]),
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
