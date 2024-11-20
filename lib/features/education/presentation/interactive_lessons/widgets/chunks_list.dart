import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/interactive_lessons_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/chunk_divider.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/lesson_components.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/continue_btn.dart';
import 'package:loopcare_frontend/features/river/domain/lesson_type.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/textarea/long_answer_textarea.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

class ChunksList extends StatefulWidget {
  const ChunksList({super.key});

  @override
  State<ChunksList> createState() => _ChunksListState();
}

class _ChunksListState extends State<ChunksList> {
  ScrollController scrollController = ScrollController();

  List<Widget> _renderChunk(InteractiveLessonsStateData blocState,
      InteractiveLessonChunk chunk) {
    final components = blocState.getChunkComponents(chunk);
    final renderedChunks = blocState.activePageUnlockedChunks;
    final showButton = renderedChunks.last.id == chunk.id;
    final buttonEndbledOrDisabled =
        renderedChunks.last.id == chunk.id && blocState.isAllComponentChecked;
    final showDivider =
        chunk.id != renderedChunks.last.id && renderedChunks.length > 1;

    return [
      ..._renderChunkComponents(components),
      if (showDivider) const ChunkDivider(),
      if (showButton)
        ContinueBtn(
            onPressed: _onContinueHandler, isDisable: !buttonEndbledOrDisabled),
    ];
  }

  void onSaveProgress(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) {
    final bloc = context.read<InteractiveLessonsBloc>();
    bloc.add(InteractiveLessonsEvent.saveAnswer(progress, component));
  }

  List<Widget> _renderChunkComponents(
      List<InteractiveLessonChunkComponent> components) {
    final bloc = context.read<InteractiveLessonsBloc>();
    final blocState = bloc.state.data;
    final lessonStreamType =
    RiverModuleStreamType.getLessonStreamType(blocState.type);

    return [
      ...components
          .map((c) =>
      switch (c) {
        InteractiveLessonChunkComponentMarkdown() =>
            Markdown(component: c),
      // InteractiveLessonChunkComponentImage() =>
      //   CachedNetworkImage(imageUrl: c.content.src),
        InteractiveLessonChunkComponentScale() =>
            Scale(
              component: c,
              lessonStreamType: lessonStreamType,
              onSaveProgress: onSaveProgress,
            ),
        InteractiveLessonChunkComponentSingleSelect() =>
            SingleSelect(
              component: c,
              lessonStreamType: lessonStreamType,
              onSaveProgress: onSaveProgress,
            ),
        InteractiveLessonChunkComponentMultipleSelect() =>
            MultipleSelect(
              component: c,
              lessonStreamType: lessonStreamType,
              onSaveProgress: onSaveProgress,
            ),
        InteractiveLessonChunkComponentSingleSelectWithFeedback() =>
            SingleSelectWithFeedback(
              component: c,
              lessonStreamType: lessonStreamType,
              onSaveProgress: onSaveProgress,
            ),
        InteractiveLessonChunkComponentOrdering() =>
            Ordering(
              component: c,
              lessonStreamType: lessonStreamType,
              onSaveProgress: onSaveProgress,
            ),
        InteractiveLessonChunkComponentTextArea() =>
            LongAnswerTextArea(
              component: c,
              lessonStreamType: lessonStreamType,
              onSaveProgress: onSaveProgress,
            ),
        _ => const SizedBox.shrink(),
      })
          .toList(),
    ];
  }

  Future<void> _onWillPop(BuildContext context, bool canPop) async {
    final navBloc = context.read<InteractiveLessonsBloc>();

    if (canPop) {
      context.router.maybePop();
    } else {
      navBloc.add(const InteractiveLessonsEvent.setPrevPage());
    }
  }

  void _onContinueHandler() {
    final bloc = context.read<InteractiveLessonsBloc>();
    final blocState = bloc.state.data;
    final lessonStreamType =
    RiverModuleStreamType.getLessonStreamType(blocState.type);
    if (blocState.isAllChunksUnlocked && blocState.isLastPage) {
      context.router.push(LessonCompleteRoute(
          lessonType: LessonType.interactive, streamType: lessonStreamType));
    } else if (blocState.isAllChunksUnlocked && !blocState.isLastPage) {
      bloc.add(const InteractiveLessonsEvent.setNextPage());
    } else {
      bloc.add(const InteractiveLessonsEvent.unlockNextChunk());
      scrollToNextChunk();
    }
  }

  void scrollToNextChunk() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!scrollController.hasClients || !mounted) return;

      await scrollController.animateTo(
        scrollController.position.pixels + 500,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );

      if (!scrollController.hasClients || !mounted) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
      builder: (context, state) {
        final componentsList = state.data.activePageUnlockedChunks
            .expand((chunk) => _renderChunk(state.data, chunk))
            .toList();

        return PopScope(
          canPop: state.data.activePageIndex == 0,
          onPopInvokedWithResult: (canPop, _) => _onWillPop(context, canPop),
          child: ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 20),
            itemCount: componentsList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) => componentsList[index],
          ),
        );
      },
    );
  }
}
