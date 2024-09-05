import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class GroupPrefsProgress extends StatelessWidget {
  const GroupPrefsProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
      builder: (context, state) {
        if (state.data.groupPrefsMode == GroupPrefsMode.groupingLesson) {
          return BlocBuilder<EducationLessonBloc, EducationLessonState>(
            builder: (context, state) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 14.0),
                    SizedBox(
                      width: 96.0,
                      child: SimpleProgressBar(progress: state.data.progress),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
