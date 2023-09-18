import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/orange_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_progress.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';

class GenderPreferencesPage extends StatefulWidget {
  const GenderPreferencesPage({Key? key}) : super(key: key);

  @override
  State<GenderPreferencesPage> createState() => _GenderPreferencesPageState();
}

class _GenderPreferencesPageState extends State<GenderPreferencesPage> {
  GenderPreferences? _selectedValue;

  @override
  void initState() {
    _selectedValue = context.read<GroupPreferencesBloc>().state.data.genderPreferences;

    super.initState();
  }

  void _onSelected(GenderPreferences value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void _onNextPressedHandler() {
    context.read<GroupPreferencesBloc>().add(GroupPreferencesEvent.setGenderPreferences(_selectedValue!));
  }

  void _onChangeListener(BuildContext context, GroupPreferencesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  void _onErrorHandler(GroupPreferencesState state) {
    final String? errorMessage = state.data.error?.maybeMap(
      unprocessableEntity: (s) => s.error.message,
      orElse: () => LocalizedTexts.somethingWentWrong.tr(),
    );

    context.showErrorBar(
      content: Text(errorMessage ?? ''),
      position: FlashPosition.top,
    );
  }

  void _onUpdateHandler(GroupPreferencesState state) {
    final groupPrefsMode = context.read<GroupPreferencesBloc>().state.data.groupPrefsMode;

    if (groupPrefsMode == GroupPrefsMode.groupingLesson) {
      context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward());
    }

    if (groupPrefsMode == GroupPrefsMode.singlePage) {
      context.router.pop();
    } else {
      context.router.pushNamed(AppRoutes.timezone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupPreferencesBloc, GroupPreferencesState>(
      listenWhen: (prev, cur) => context.router.current.name == GenderPreferencesRoute.name,
      listener: _onChangeListener,
      child: GroupLessonWrap(
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
                          LocalizedTexts.genderPreferencesQuestion,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ).tr(),
                        const SizedBox(height: 24.0),
                        Column(
                          children: GenderPreferences.values.map(
                            (GenderPreferences value) {
                              final gender = context.read<AuthenticationCubit>().state.gender;
                              final shouldRemoveMale =
                                  gender == SexType.male && value == GenderPreferences.femaleOnly;
                              final shouldRemoveFemale =
                                  gender == SexType.female && value == GenderPreferences.maleOnly;

                              if (shouldRemoveMale || shouldRemoveFemale) return const SizedBox.shrink();

                              return Column(
                                children: [
                                  AppChoiceChip(
                                    label: value.label,
                                    selected: value == _selectedValue,
                                    value: value,
                                    onSelected: _onSelected,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              );
                            },
                          ).toList(),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        OrangeButton(
                          onPressedHandler: _selectedValue == null ? null : _onNextPressedHandler,
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
      ),
    );
  }
}
