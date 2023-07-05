import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/progress_item.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_card.dart';

class EducationFullList extends StatefulWidget {
  final List<EducationLesson> lessons;

  const EducationFullList({Key? key, required this.lessons}) : super(key: key);

  @override
  State<EducationFullList> createState() => _EducationFullListState();
}

class _EducationFullListState extends State<EducationFullList> with WidgetsBindingObserver {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('addPostFrameCallback ${_controller.position}');
      _controller.jumpTo(200);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
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
            childCount: widget.lessons.length,
          ),
        ),
      ],
    );
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      controller: _controller,
      itemCount: widget.lessons.length,
      itemBuilder: (BuildContext context, index) {
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
