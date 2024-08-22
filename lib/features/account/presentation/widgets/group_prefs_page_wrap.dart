import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/keyboard_listener_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

class GroupPrefsPageWrap extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool fromLessonComplete;
  final RiverModuleStreamType streamType;

  const GroupPrefsPageWrap({
    super.key,
    required this.child,
    this.title,
    required this.fromLessonComplete,
    this.streamType = RiverModuleStreamType.psychology,
  });

  Color get _scaffoldColor =>
      fromLessonComplete ? streamType.lightestColor : AppColors.blueLightest;

  Color get _appBarColor => fromLessonComplete ? streamType.regularColor : AppColors.blueRegular;

  CustomAppBarTextTheme get _appBarTextTheme =>
      fromLessonComplete ? streamType.appBarTextTheme : CustomAppBarTextTheme.light;

  Color get _leadingButtonColor =>
      fromLessonComplete ? streamType.lighterColor : AppColors.blueLighter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPreferencesBloc, GroupPreferencesState>(
      builder: (context, state) {
        return KeyboardContainerListener(
          child: CustomScaffold(
            color: _scaffoldColor,
            body: child,
            appBar: CustomAppBar(
              backgroundColor: _appBarColor,
              textTheme: _appBarTextTheme,
              title: title ?? LocalizedTexts.supportGroupPreferences.tr(),
              leading: CustomFilledIconButton.fromColor(color: _leadingButtonColor),
            ),
          ),
        );
      },
    );
  }
}
