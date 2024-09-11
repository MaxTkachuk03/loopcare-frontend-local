import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/search_field.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_lesson_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/group_prefs_page_wrap.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timezone/timezone.dart';

@RoutePage()
class TimezonePreferencesPage extends StatefulWidget {
  final RiverModuleStreamType streamType;
  final bool fromLessonComplete;

  const TimezonePreferencesPage({
    super.key,
    required this.fromLessonComplete,
    this.streamType = RiverModuleStreamType.psychology,
  });

  @override
  State<TimezonePreferencesPage> createState() => _TimezonePreferencesPageState();
}

class _TimezonePreferencesPageState extends State<TimezonePreferencesPage> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  List<String> locations = <String>[];
  String? _selectedLocation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setupTimeZone();
  }

  void _setupTimeZone() {
    final sortedLocations = timeZoneDatabase.locations.values
        .sorted((a, b) => a.currentTimeZone.offset.compareTo(b.currentTimeZone.offset));

    locations = sortedLocations
        .map((e) =>
            '${e.name.split('/').join(', ')} (${e.zones.last.abbreviation} ${Duration(milliseconds: e.currentTimeZone.offset).inHours}:00)')
        .toList();

    final selectedLocationIndex = locations.indexWhere((item) {
      var timezone = context.read<GroupPreferencesBloc>().state.data.timezone;
      if (timezone == null) {
        return false;
      }
      return item.toLowerCase().contains(timezone.toLowerCase());
    });

    final index = selectedLocationIndex.isNegative
        ? sortedLocations.indexWhere((e) {
            return e.currentTimeZone.abbreviation == DateTime.now().timeZoneName &&
                e.currentTimeZone.offset == DateTime.now().timeZoneOffset.inMilliseconds;
          })
        : selectedLocationIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _itemScrollController.scrollTo(index: index, duration: const Duration(milliseconds: 300));
    });

    _selectedLocation = locations[index];
  }

  void _onErrorHandler(GroupPreferencesState state) =>
      context.showError(content: CustomText(state.data.errorKey.tr()));

  void _onUpdateHandler(GroupPreferencesState state) {
    final groupPrefsMode = context.read<GroupPreferencesBloc>().state.data.groupPrefsMode;

    if (groupPrefsMode == GroupPrefsMode.groupingLesson) {
      // context.read<EducationLessonBloc>().add(const EducationLessonEvent.progressForward());
    }

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userFillsOutTimezonePreferences,
      parameters: {
        AnalyticsParameters.navigatedFrom:
            widget.fromLessonComplete ? 'Lesson content' : 'User profile',
      },
    );

    if (groupPrefsMode == GroupPrefsMode.singlePage) {
      context.router.maybePop();
    } else {
      context.router.push(NicknamePreferencesRoute(
        fromLessonComplete: widget.fromLessonComplete,
        streamType: widget.streamType,
      ));
    }
  }

  void _onChangeListener(BuildContext context, GroupPreferencesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  Widget _getCustomChoiceChip({
    required String label,
    required bool selected,
    required String value,
  }) {
    if (widget.fromLessonComplete) {
      return CustomChoiceChip.green(
        label: label,
        selected: selected,
        value: value,
        onSelected: onSelected,
      );
    }
    return CustomChoiceChip.coral(
      label: label,
      selected: selected,
      value: value,
      onSelected: onSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupPreferencesBloc, GroupPreferencesState>(
      listenWhen: (prev, cur) => context.router.current.name == TimezonePreferencesRoute.name,
      listener: _onChangeListener,
      child: GroupLessonWrap(
        fromLessonComplete: widget.fromLessonComplete,
        child: GroupPrefsPageWrap(
          streamType: widget.streamType,
          fromLessonComplete: widget.fromLessonComplete,
          child: CustomSafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const GroupPrefsProgress(),
                const SizedBox(height: 28.0),
                MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.bitter500(
                        LocalizedTexts.whatIsYourTimezone.tr(),
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 20.0),
                      SearchField(
                        hintText: LocalizedTexts.searchTimezone.tr(),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.greyLabel,
                        ),
                        onChanged: _onSearch,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28.0),
                Expanded(
                  child: ScrollablePositionedList.separated(
                    itemScrollController: _itemScrollController,
                    itemCount: locations.length,
                    itemBuilder: (BuildContext context, index) {
                      final item = locations[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: _getCustomChoiceChip(
                          label: item,
                          selected: _selectedLocation == item,
                          value: item,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8.0);
                    },
                  ),
                ),
                MainContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 24.0),
                      CustomElevatedButton.blueFullWidth(
                        onPressed: _selectedLocation == null ? null : _onNextPressedHandler,
                        label: widget.fromLessonComplete
                            ? LocalizedTexts.next.tr()
                            : LocalizedTexts.save.tr(),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSelected(String value) {
    setState(() {
      _selectedLocation = value;
    });
  }

  void _onNextPressedHandler() {
    context.read<GroupPreferencesBloc>().add(GroupPreferencesEvent.setTimezone(_selectedLocation!));
  }

  void _onSearch(String value) {
    if (value.isEmpty) {
      resetSelectedItem();

      return;
    }

    final index = locations.indexWhere((item) => item.toLowerCase().contains(value.toLowerCase()));

    if (!index.isNegative) {
      _itemScrollController.jumpTo(index: index);
      setState(() {
        _selectedLocation = locations[index];
      });
    } else {
      resetSelectedItem();
    }
  }

  void resetSelectedItem() {
    _itemScrollController.jumpTo(index: 0);
    setState(() {
      _selectedLocation = null;
    });
  }
}
