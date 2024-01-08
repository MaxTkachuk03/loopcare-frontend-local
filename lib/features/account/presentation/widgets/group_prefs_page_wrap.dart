import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';

class GroupPrefsPageWrap extends StatelessWidget {
  final Widget child;
  final String? title;

  const GroupPrefsPageWrap({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
      builder: (context, state) {
        if (state.data.groupPrefsMode == GroupPrefsMode.groupingLesson) {
          return KeyboardContainerListener(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  title ?? LocalizedTexts.supportGroupPreferences,
                  style: Theme.of(context).textTheme.titleMedium,
                ).tr(),
              ),
              body: child,
            ),
          );
        }

        return KeyboardContainerListener(
          child: CustomScaffold.blueLightest(
            appBar: CustomAppBar.blue(
              leading: CustomFilledIconButton.leadingBlueLighter(),
              title: title ?? LocalizedTexts.groupPreferences.translation,
            ),
            body: child,
          ),
        );
      },
    );
  }
}
