import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/interactive_lessons_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/chunk_divider.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/lesson_components.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/meal_timing/meal_timing.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/continue_btn.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_intake_page/application/nutrition_intake_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/lesson_type.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

class ChunksList extends StatefulWidget {
  const ChunksList({super.key});

  @override
  State<ChunksList> createState() => _ChunksListState();
}

class _ChunksListState extends State<ChunksList> {
  ScrollController scrollController = ScrollController();
  final GlobalKey widgetKey = GlobalKey();

  List<Widget> _renderChunk(InteractiveLessonsStateData blocState, InteractiveLessonChunk chunk) {
    final components = blocState.getChunkComponents(chunk);
    final renderedChunks = blocState.activePageUnlockedChunks;
    final showButton = renderedChunks.last.id == chunk.id;
    final buttonEnabledOrDisabled =
        renderedChunks.last.id == chunk.id && blocState.isAllComponentChecked;
    final showDivider = chunk.id != renderedChunks.last.id && renderedChunks.length > 1;

    return [
      ..._renderChunkComponents(components),
      if (showDivider) const ChunkDivider(),
      if (showButton)
        ContinueBtn(onPressed: _onContinueHandler, isDisable: !buttonEnabledOrDisabled),
    ];
  }

  void onSaveProgress(
      InteractiveLessonComponentProgress progress, InteractiveLessonChunkComponent component) {
    final bloc = context.read<InteractiveLessonsBloc>();
    bloc.add(InteractiveLessonsEvent.saveAnswer(progress, component));
  }

  List<Widget> _renderChunkComponents(List<InteractiveLessonChunkComponent> components) {
    final bloc = context.read<InteractiveLessonsBloc>();
    final blocState = bloc.state.data;
    final lessonStreamType = RiverModuleStreamType.getLessonStreamType(blocState.type);
    final lessonStatus = blocState.lessonStatus;

    if (lessonStatus == RiverModuleItemState.completed ||
        lessonStatus == RiverModuleItemState.read) {
      bloc.add(const InteractiveLessonsEvent.unlockNextChunk());
    }

    return [
      ...components.map((c) => switch (c) {
            InteractiveLessonChunkComponentMarkdown() => Markdown(component: c),
            InteractiveLessonChunkComponentImage() => LessonImage(component: c),
            //   CachedNetworkImage(imageUrl: c.content.src),
            InteractiveLessonChunkComponentScale() => Scale(
                component: c,
                lessonStreamType: lessonStreamType,
                onSaveProgress: onSaveProgress,
              ),
            InteractiveLessonChunkComponentSingleSelect() => SingleSelect(
                component: c,
                lessonStreamType: lessonStreamType,
                onSaveProgress: onSaveProgress,
              ),
            InteractiveLessonChunkComponentMultipleSelect() => MultipleSelect(
                component: c,
                lessonStreamType: lessonStreamType,
                onSaveProgress: onSaveProgress,
              ),
            InteractiveLessonChunkComponentSingleSelectWithFeedback() => SingleSelectWithFeedback(
                component: c,
                lessonStreamType: lessonStreamType,
                onSaveProgress: onSaveProgress,
              ),
            InteractiveLessonChunkComponentOrdering() => Ordering(
                component: c,
                lessonStreamType: lessonStreamType,
                onSaveProgress: onSaveProgress,
              ),
            InteractiveLessonChunkComponentTextArea() => LongAnswerTextArea(
                key: ValueKey('${c.id}_${c.chunkId}'),
                component: c,
                lessonStreamType: lessonStreamType,
                onSaveProgress: onSaveProgress,
                isAllTextAreasAdded: blocState.allTextAreasAdded,
              ),
            InteractiveLessonChunkComponentSurvey() => Survey(
                component: c,
                lessonStreamType: lessonStreamType,
                onSaveProgress: onSaveProgress,
              ),
            InteractiveLessonChunkComponentMealTiming() => MealTiming(
                component: c,
                lessonStreamType: lessonStreamType,
                onSaveProgress: onSaveProgress,
              ),
            _ => const SizedBox.shrink(),
          }),
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
    final lessonStreamType = RiverModuleStreamType.getLessonStreamType(blocState.type);

    final blocNutritionIntake = context.read<NutritionIntakeBloc>();
    final blocNutritionIntakeState = blocNutritionIntake.state.data;

    Future.delayed(const Duration(seconds: 1), () {
      const source = 'NutritionIntakeRoute';
      if (blocState.isAllChunksUnlocked && blocState.isLastPage) {
        if (mounted) {
          if (context.router.stack[1].routeData.name.toLowerCase() == source.toLowerCase()) {
            blocNutritionIntake.add(NutritionIntakeEvent.finishLesson(
                date: context.read<MealsBloc>().state.data.currentDateTime,
                iLessonId: blocNutritionIntakeState.iLessonId));

            context.router.popUntilRouteWithName(NutritionIntakeRoute.name);

            blocNutritionIntake.add(NutritionIntakeEvent.fetchProgress(
                date: context.read<MealsBloc>().state.data.currentDateTime));

            return;
          }

          context.router.push(LessonCompleteRoute(
              lessonType: LessonType.interactive, streamType: lessonStreamType));
        }
      } else if (blocState.isAllChunksUnlocked && !blocState.isLastPage) {
        bloc.add(const InteractiveLessonsEvent.setNextPage());
        scrollToNextChunk(false);
      } else {
        bloc.add(const InteractiveLessonsEvent.unlockNextChunk());
        scrollToNextChunk(true);
      }
    });
  }

  void scrollToNextChunk(bool betweenChunks) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!scrollController.hasClients || !mounted) return;
      await Future.delayed(const Duration(milliseconds: 100));

      if (!mounted) return;

      final double chunkHeight = calculateDynamicHeight();
      if (chunkHeight == 0.0) return;
      double newScrollPosition = 0.0;
      if (chunkHeight <= 350) {
        newScrollPosition =
            betweenChunks ? scrollController.position.pixels + chunkHeight - 200.0 : 0.0;
      } else {
        newScrollPosition =
            betweenChunks ? scrollController.position.pixels + chunkHeight - 90.0 : 0.0;
      }
      await scrollController.animateTo(
        newScrollPosition,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
      if (!scrollController.hasClients || !mounted) return;
    });
  }

  double calculateDynamicHeight() {
    final RenderBox? box = widgetKey.currentContext?.findRenderObject() as RenderBox?;

    return box?.size.height ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
      builder: (context, state) {
        final componentsList = state.data.activePageUnlockedChunks
            .expand((chunk) => _renderChunk(state.data, chunk))
            .toList();

        return MainContainer(
          child: PopScope(
            canPop: state.data.activePageIndex == 0,
            onPopInvokedWithResult: (canPop, _) => _onWillPop(context, canPop),
            child: ListView.separated(
              key: widgetKey,
              controller: scrollController,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 20),
              itemCount: componentsList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) => componentsList[index],
            ),
          ),
        );
      },
    );
  }
}
