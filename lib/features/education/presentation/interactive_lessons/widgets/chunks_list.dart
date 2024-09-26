import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/navigation/interactive_lessons_nav_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/chunk_divider.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/continue_btn.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/lesson_components.dart';

class ChunksList extends StatefulWidget {
  const ChunksList({super.key});

  @override
  State<ChunksList> createState() => _ChunksListState();
}

class _ChunksListState extends State<ChunksList> {
  List<Widget> _renderChunk(InteractiveLessonChunk chunk) {
    final navigationBlocState = context.read<InteractiveLessonsNavBloc>().state;
    final renderedChunks = navigationBlocState.data.activePageUnlockedChunks;
    final showButton = renderedChunks.last.id == chunk.id;
    final showDivider = !showButton && renderedChunks.length > 1;

    return [
      ..._renderChunkComponents(chunk.components),
      if (showDivider) const ChunkDivider(),
      if (showButton) ContinueBtn(onPressed: _onContinueHandler),
    ];
  }

  List<Widget> _renderChunkComponents(List<InteractiveLessonChunkComponent> components) {
    return components
        .map((c) => switch (c) {
              InteractiveLessonChunkComponentMarkdown() => Markdown(component: c),
              InteractiveLessonChunkComponentImage() => CachedNetworkImage(imageUrl: c.content.src),
              InteractiveLessonChunkComponentScale() => Scale(component: c),
              InteractiveLessonChunkComponentSingleSelect() => SingleSelect(component: c),
              InteractiveLessonChunkComponentMultipleSelect() => MultipleSelect(component: c),
              InteractiveLessonChunkComponentSingleSelectWithFeedback() =>
                SingleSelectWithFeedback(component: c),
              InteractiveLessonChunkComponentOrdering() => Ordering(component: c),
              _ => const SizedBox.shrink(),
            })
        .toList();
  }

  Future<void> _onWillPop(BuildContext context, bool canPop) async {
    final navBloc = context.read<InteractiveLessonsNavBloc>();

    if (canPop) {
      context.router.maybePop();
    } else {
      navBloc.add(const InteractiveLessonsNavEvent.setPrevPage());
    }
  }

  void _onContinueHandler() {
    final navBloc = context.read<InteractiveLessonsNavBloc>();
    final navBlocState = navBloc.state.data;

    if (navBlocState.isAllChunksUnlocked && navBlocState.isLastPage) {
      // TODO: add redirect to the lesson complete screen
    } else if (navBlocState.isAllChunksUnlocked && !navBlocState.isLastPage) {
      navBloc.add(const InteractiveLessonsNavEvent.setNextPage());
    } else {
      navBloc.add(const InteractiveLessonsNavEvent.unlockNextChunk());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteractiveLessonsNavBloc, InteractiveLessonsNavState>(
      builder: (context, state) {
        final componentsList = state.data.activePageUnlockedChunks.expand(_renderChunk).toList();

        return PopScope(
          canPop: state.data.activePageIndex == 0,
          onPopInvokedWithResult: (canPop, _) => _onWillPop(context, canPop),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
