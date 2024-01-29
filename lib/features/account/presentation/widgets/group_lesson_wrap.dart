import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class GroupLessonWrap extends StatelessWidget {
  final Widget child;
  final bool fromLessonComplete;

  const GroupLessonWrap({
    super.key,
    required this.child,
    required this.fromLessonComplete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => GroupPrefsPageWrap(
            fromLessonComplete: fromLessonComplete,
            child: const Loader(),
          ),
          error: (errorState) {
            final error = errorState.data.error;

            return GroupPrefsPageWrap(
              fromLessonComplete: fromLessonComplete,
              child: Center(
                child: ErrorScreen(
                  error: error,
                ),
              ),
            );
          },
          orElse: () {
            if (state.data.groupPrefsMode == GroupPrefsMode.groupingLesson) {
              return WillPopScope(
                onWillPop: () => _onWillPop(context),
                child: child,
              );
            }

            return child;
          },
        );
      },
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressBack());

    return Future.value(true);
  }
}
