import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/keyboard_state.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class NicknamePreferencesPage extends StatefulWidget {
  final bool fromLessonComplete;

  const NicknamePreferencesPage({
    super.key,
    required this.fromLessonComplete,
  });

  @override
  State<NicknamePreferencesPage> createState() => _NicknamePreferencesPageState();
}

class _NicknamePreferencesPageState extends State<NicknamePreferencesPage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var nick = context.read<GroupPreferencesBloc>().state.data.nickname;
    if (nick == null) {
      return;
    }
    _nicknameController.text = nick;
  }

  void _onNextPressedHandler() {
    dismissKeyboard(context);
    context.read<GroupPreferencesBloc>().add(GroupPreferencesEvent.setNickname(_nicknameController.text));
  }

  void _onNicknameChangeHandler(_) {
    setState(() {});
  }

  void _onChangeListener(BuildContext context, GroupPreferencesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      loading: (state) => dismissKeyboard(context),
      updated: _onUpdateHandler,
    );
  }

  void _onErrorHandler(GroupPreferencesState state) =>
      context.showError(content: Text(state.data.error?.error.toString() ?? ''));

  void _onUpdateHandler(GroupPreferencesState state) {
    final groupPrefsMode = context.read<GroupPreferencesBloc>().state.data.groupPrefsMode;

    if (groupPrefsMode == GroupPrefsMode.groupingLesson) {
      context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward());
    }

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userFillsOutNicknamePreferences,
      parameters: {
        CustomDefinitions.navigatedFrom: widget.fromLessonComplete ? 'Lesson content' : 'User profile',
        CustomDefinitions.value: _nicknameController.text,
      },
    );

    if (groupPrefsMode == GroupPrefsMode.singlePage) {
      context.router.pop();
    } else {
      context.router.push(GroupRulesOneRoute(fromLessonComplete: widget.fromLessonComplete));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupPreferencesBloc, GroupPreferencesState>(
      listenWhen: (prev, cur) => context.router.current.name == NicknamePreferencesRoute.name,
      listener: _onChangeListener,
      builder: (BuildContext context, GroupPreferencesState state) {
        return GroupLessonWrap(
          fromLessonComplete: widget.fromLessonComplete,
          child: GroupPrefsPageWrap(
            fromLessonComplete: widget.fromLessonComplete,
            child: SafeArea(
              child: MainContainer(
                child: ScrollableContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          // const GroupPrefsProgress(),
                          const SizedBox(height: 28.0),
                          CustomText.bitter500(
                            LocalizedTexts.nicknamePreferencesQuestion.tr(),
                            style: context.textTheme.displayMedium,
                          ),
                          const SizedBox(height: 24.0),
                          CustomTextField.nickname(
                            onChanged: _onNicknameChangeHandler,
                            controller: _nicknameController,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          CustomElevatedButton.blueFullWidth(
                            onPressed: _nicknameController.text.isEmpty ? null : _onNextPressedHandler,
                            label: widget.fromLessonComplete
                                ? LocalizedTexts.next.tr()
                                : LocalizedTexts.save.tr(),
                          ),
                          const SizedBox(height: 30.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();

    super.dispose();
  }
}
