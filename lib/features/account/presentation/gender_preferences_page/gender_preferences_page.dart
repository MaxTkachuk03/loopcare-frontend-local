import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/account/gender_preferences.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/injection.dart';

@RoutePage()
class GenderPreferencesPage extends StatefulWidget {
  final RiverModuleStreamType streamType;
  final bool fromLessonComplete;

  const GenderPreferencesPage({
    super.key,
    required this.fromLessonComplete,
    this.streamType = RiverModuleStreamType.psychology,
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
    context
        .read<GroupPreferencesBloc>()
        .add(GroupPreferencesEvent.setGenderPreferences(_selectedValue!));
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
      orElse: () => LocalizedTexts.errorSomethingWentWrong,
    );

    context.showErrorBar(
      content: CustomText(errorMessage?.tr() ?? LocalizedTexts.errorSomethingWentWrong.tr()),
      position: FlashPosition.top,
    );
  }

  void _onUpdateHandler(GroupPreferencesState state) {
    final groupPrefsMode = context.read<GroupPreferencesBloc>().state.data.groupPrefsMode;

    if (groupPrefsMode == GroupPrefsMode.groupingLesson) {
      // context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward());
    }

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userFillsOutGenderPreferences,
      parameters: {
        AnalyticsParameters.navigatedFrom:
            widget.fromLessonComplete ? 'Lesson content' : 'User profile',
        AnalyticsParameters.value: _selectedValue?.name,
      },
    );

    if (groupPrefsMode == GroupPrefsMode.singlePage) {
      context.router.maybePop();
    } else {
      context.router.push(TimezonePreferencesRoute(
        fromLessonComplete: widget.fromLessonComplete,
        streamType: widget.streamType,
      ));
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
          streamType: widget.streamType,
          fromLessonComplete: widget.fromLessonComplete,
          child: CustomSafeArea(
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
                              final gender = getIt<SharedStorageService>().account?.gender;
                              final shouldRemoveMale =
                                  gender == GenderType.man && value == GenderPreferences.femaleOnly;
                              final shouldRemoveFemale =
                                  gender == GenderType.woman && value == GenderPreferences.maleOnly;

                              if (shouldRemoveMale || shouldRemoveFemale) {
                                return const SizedBox.shrink();
                              }

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
      ),
    );
  }
}
