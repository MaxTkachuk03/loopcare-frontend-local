import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';

class GroupLessonWrap extends StatelessWidget {
  final Widget child;

  const GroupLessonWrap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => const GroupPrefsPageWrap(
            child: Loader(),
          ),
          error: (errorState) {
            final error = errorState.data.error;

            return GroupPrefsPageWrap(
              child: Center(
                child: ErrorScreen(
                  error: error!,
                ),
              ),
            );
          },
          orElse: () => child,
        );
      },
    );
  }
}
