import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class GroupPrefsPageWrap extends StatelessWidget {
  final Widget child;
  final String? title;

  const GroupPrefsPageWrap({
    super.key,
    required this.child,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
      builder: (context, state) {
        return KeyboardContainerListener(
          child: CustomScaffold.blueLightest(
            appBar: CustomAppBar.blue(
              title: title ?? LocalizedTexts.supportGroupPreferences.tr(),
              leading: CustomFilledIconButton.leadingBlueLighter(),
            ),
            body: child,
          ),
        );
      },
    );
  }
}
