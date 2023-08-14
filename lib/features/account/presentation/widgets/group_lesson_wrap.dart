import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class GroupLessonWrap extends StatelessWidget {
  final Widget child;

  const GroupLessonWrap({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
      builder: (context, state) {
        if (state.data.groupPrefsMode == GroupPrefsMode.groupingLesson) {
          return WillPopScope(
            onWillPop: () => _onWillPop(context),
            child: child,
          );
        }

        return child;
      },
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressBack());

    return Future.value(true);
  }
}
