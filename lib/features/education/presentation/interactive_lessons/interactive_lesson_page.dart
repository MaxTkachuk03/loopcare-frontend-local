import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/bloc/interactive_lessons_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/controller/interactive_lesson_controller.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/lesson_components.dart';

@RoutePage()
class InteractiveLessonPage extends StatefulWidget {
  const InteractiveLessonPage({super.key});

  @override
  State<InteractiveLessonPage> createState() => _InteractiveLessonPageState();
}

class _InteractiveLessonPageState extends State<InteractiveLessonPage> {
  final InteractiveLessonNavigationController _navigationController =
      InteractiveLessonNavigationController();

  void _onLessonsListener(BuildContext context, InteractiveLessonsState state) {
    if (state is! InteractiveLessonsStateLessonLoaded) return;
    final interactiveLesson = state.data.interactiveLesson;

    if (interactiveLesson == null) return;

    _navigationController.setInitialData(interactiveLesson.topics.first.pages.first);
  }

  List<Widget> _renderChunk(InteractiveLessonChunk chunk) {
    return chunk.components
        .map((c) => switch (c) {
              InteractiveLessonChunkComponentMarkdown() => Markdown(component: c),
              InteractiveLessonChunkComponentImage() => CachedNetworkImage(imageUrl: c.content.src),
              InteractiveLessonChunkComponentScale() => Scale(component: c),
              _ => const SizedBox.shrink(),
            })
        .toList();
  }

  Widget _buildLessonContent() {
    return ValueListenableBuilder<List<InteractiveLessonChunk>>(
      valueListenable: _navigationController.renderedChunks,
      builder: (context, chunks, _) {
        return Column(children: chunks.expand(_renderChunk).toList());
      },
    );
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
                    orElse: _buildLessonContent,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }
}
