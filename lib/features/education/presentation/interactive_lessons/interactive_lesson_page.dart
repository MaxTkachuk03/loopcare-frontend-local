import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/interactive_lessons_bloc.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/navigation/interactive_lessons_nav_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/chunks_list.dart';

@RoutePage()
class InteractiveLessonPage extends StatelessWidget {
  const InteractiveLessonPage({super.key});

  void _onLessonsListener(BuildContext context, InteractiveLessonsState state) {
    if (state is! InteractiveLessonsStateLessonLoaded) return;
    final interactiveLesson = state.data.interactiveLesson;

    if (interactiveLesson == null) return;

    context
        .read<InteractiveLessonsNavBloc>()
        .add(InteractiveLessonsNavEvent.setInitial(interactiveLesson.topics.first.pages));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InteractiveLessonsBloc, InteractiveLessonsState>(
      listener: _onLessonsListener,
      child: CustomScaffold.greenLightest(
        appBar: CustomAppBar.green(leading: CustomFilledIconButton.leadingGreenLighter()),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    error: (_) => const SizedBox.shrink(),
                    loading: (_) => const Center(child: CircularProgressIndicator()),
                    orElse: () => const ChunksList(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
