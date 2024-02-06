import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/sex_type.dart';

class GenderPreferencesPage extends StatefulWidget {
  final bool fromLessonComplete;

  const GenderPreferencesPage({
    super.key,
    required this.fromLessonComplete,
  });

  @override
  State<GenderPreferencesPage> createState() => _GenderPreferencesPageState();
}

class _GenderPreferencesPageState extends State<GenderPreferencesPage> {
  GenderPreferences? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = context.read<GroupPreferencesBloc>().state.data.genderPreferences;
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
      content: CustomText(errorMessage ?? ''),
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
      context.router.push(TimezonePreferencesRoute(fromLessonComplete: widget.fromLessonComplete));
    }
  }

  Widget _getCustomChoiceChip({
    required String label,
    required bool selected,
    required GenderPreferences value,
  }) {
    if (widget.fromLessonComplete) {
      return CustomChoiceChip.green(
        label: label,
        selected: selected,
        value: value,
        onSelected: _onSelected,
      );
    }
    return CustomChoiceChip.coral(
      label: label,
      selected: selected,
      value: value,
      onSelected: _onSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupPreferencesBloc, GroupPreferencesState>(
      listenWhen: (prev, cur) => context.router.current.name == GenderPreferencesRoute.name,
      listener: _onChangeListener,
      child: GroupLessonWrap(
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
                          LocalizedTexts.genderPreferencesQuestion.tr(),
                          style: context.textTheme.displayMedium,
                        ),
                        const SizedBox(height: 24.0),
                        Column(
                          children: GenderPreferences.values.map(
                            (GenderPreferences value) {
                              final gender = context.read<AuthenticationCubit>().state.gender;
                              final shouldRemoveMale = gender == SexType.male && value == GenderPreferences.femaleOnly;
                              final shouldRemoveFemale =
                                  gender == SexType.female && value == GenderPreferences.maleOnly;

                              if (shouldRemoveMale || shouldRemoveFemale) return const SizedBox.shrink();

                              return Column(
                                children: [
                                  _getCustomChoiceChip(
                                    label: value.label,
                                    selected: value == _selectedValue,
                                    value: value,
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
                        CustomElevatedButton.blueFullWidth(
                          onPressed: _selectedValue == null ? null : _onNextPressedHandler,
                          label:
                              widget.fromLessonComplete ? LocalizedTexts.next.tr() : LocalizedTexts.save.tr(),
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
