import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topics_page.dart';

class InteractiveLessonNavigationController {
  InteractiveLessonNavigationController();

  ValueNotifier<InteractiveLessonTopicsPage?> activePage = ValueNotifier(null);
  ValueNotifier<InteractiveLessonChunk?> activeChunk = ValueNotifier(null);
  ValueNotifier<List<InteractiveLessonChunk>> renderedChunks = ValueNotifier([]);

  void setActivePage(InteractiveLessonTopicsPage? page) => activePage.value = page;
  void setActiveChunk(InteractiveLessonChunk? chunk) => activeChunk.value = chunk;
  void addRenderedChunk(InteractiveLessonChunk chunk) => renderedChunks.value.add(chunk);

  void setInitialData(InteractiveLessonTopicsPage page) {
    setActivePage(page);
    setActiveChunk(page.chunks.first);
    addRenderedChunk(page.chunks.first);
  }

  void dispose() {
    activePage.dispose();
    activeChunk.dispose();
    renderedChunks.dispose();
  }
}
