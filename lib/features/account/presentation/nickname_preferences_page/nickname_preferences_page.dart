import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/utils/keyboard_state.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/orange_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_progress.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';

class NicknamePreferencesPage extends StatefulWidget {
  const NicknamePreferencesPage({Key? key}) : super(key: key);

  @override
  State<NicknamePreferencesPage> createState() => _NicknamePreferencesPageState();
}

class _NicknamePreferencesPageState extends State<NicknamePreferencesPage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nicknameController.text = context.read<GroupPreferencesBloc>().state.data.nickname;
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

  void _onErrorHandler(GroupPreferencesState state) {
    context.showErrorBar(content: Text(state.data.error?.error.toString() ?? ''), position: FlashPosition.top);
  }

  void _onUpdateHandler(GroupPreferencesState state) {
    final groupPrefsMode = context.read<GroupPreferencesBloc>().state.data.groupPrefsMode;

    if (groupPrefsMode == GroupPrefsMode.groupingLesson) {
      context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward());
    }

    if (groupPrefsMode == GroupPrefsMode.singlePage) {
      context.router.pop();
    } else {
      context.router.pushNamed(AppRoutes.groupRulesOne);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupPreferencesBloc, GroupPreferencesState>(
      listenWhen: (prev, cur) => context.router.current.name == NicknamePreferencesRoute.name,
      listener: _onChangeListener,
      builder: (BuildContext context, GroupPreferencesState state) {
        return GroupLessonWrap(
          child: GroupPrefsPageWrap(
            child: SafeArea(
              child: MainContainer(
                child: ScrollableContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          const GroupPrefsProgress(),
                          const SizedBox(height: 28.0),
                          const Text(
                            LocalizedTexts.nicknamePreferencesQuestion,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ).tr(),
                          const SizedBox(height: 24.0),
                          TextField(
                            autofocus: context.router.current.name == NicknamePreferencesRoute.name,
                            keyboardType: TextInputType.name,
                            onChanged: _onNicknameChangeHandler,
                            controller: _nicknameController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: LocalizedTexts.nicknamePlaceholder.tr(),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          OrangeButton(
                            onPressedHandler: _nicknameController.text.isEmpty ? null : _onNextPressedHandler,
                            child: const Text(LocalizedTexts.next).tr(),
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
