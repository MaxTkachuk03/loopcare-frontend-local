import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';

class GroupPrefsPageWrap extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool fromLessonComplete;

  const GroupPrefsPageWrap({
    super.key,
    required this.child,
    this.title,
    required this.fromLessonComplete,
  });
  CustomAppBar _getCustomAppBar({
    required String title,
  }) {
    if (fromLessonComplete) {
      return CustomAppBar.petrol(
        title: title,
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      );
    }
    return CustomAppBar.blue(
      title: title,
      leading: CustomFilledIconButton.leadingBlueLighter(),
    );
  }

  CustomScaffold _getCustomScaffold({
    Widget? body,
    required String title,
  }) {
    if (fromLessonComplete) {
      return CustomScaffold.petrolLightest(
        appBar: _getCustomAppBar(
          title: title,
        ),
        body: body,
      );
    }
    return CustomScaffold.blueLightest(
      appBar: _getCustomAppBar(
        title: title,
      ),
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
      builder: (context, state) {
        return KeyboardContainerListener(
          child: _getCustomScaffold(
            title: title ?? LocalizedTexts.supportGroupPreferences.tr(),
            body: child,
          ),
        );
      },
    );
  }
}
