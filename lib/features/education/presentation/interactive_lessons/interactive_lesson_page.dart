import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/education/application/interactive_lessons/interactive_lessons_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/chunks_list.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

@RoutePage()
class InteractiveLessonPage extends StatelessWidget {
  const InteractiveLessonPage({super.key});

  int getProgressPercentage(InteractiveLessonsState state) {
    final activePage = state.data.activePage;
    if (activePage == null || activePage.chunksIds.isEmpty) return 0;

    return (((state.data.activeChunkIndex + 1) /
                (activePage.chunksIds.length)) *
            100)
        .round();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<InteractiveLessonsBloc>().state.data;
    final lessonStreamType =
        RiverModuleStreamType.getLessonStreamType(bloc.type);

    return BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
        builder: (context, state) {
      return state.maybeWhen(
        error: (_) => const SizedBox.shrink(),
        loading: (_) => CustomScaffold.greenLightest(
          body: const Center(child: CircularProgressIndicator()),
        ),
        orElse: () => CustomScaffold.greenLightest(
          appBar: CustomAppBar.customColor(
            customColor: lessonStreamType.regularColor,
            title: context.watch<InteractiveLessonsBloc>().state.data.title,
            leading: CustomFilledIconButton.fromColor(
                color: lessonStreamType.lighterColor),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child:
                  BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
                builder: (context, state) {
                  return ProgressBar(
                    backgroundColor: lessonStreamType.regularColor,
                    progressFillColor: AppColors.white,
                    progressEmptyColor: AppColors.white.withOpacity(0.4),
                    segments: state.data.pages.length,
                    value: state.data.activePageIndex,
                    progress: getProgressPercentage(state).clamp(0, 100),
                  );
                },
              ),
            ),
          ),
          body: CustomSafeArea(
            child:
                // ScrollableContainer(
                MainContainer(
              child:
                  BlocBuilder<InteractiveLessonsBloc, InteractiveLessonsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    error: (_) => const SizedBox.shrink(),
                    loading: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    orElse: () => const ChunksList(),
                  );
                },
              ),
            ),
            // ),
          ),
        ),
      );
    });
  }
}
