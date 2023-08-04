import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/widgets/orange_button.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/domain/group_prefs_mode.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/back_button_hexagon/back_button_hexagon.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timezone/timezone.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/search_field.dart';

class TimezonePreferencesPage extends StatefulWidget {
  final GroupPrefsMode groupPrefsMode;

  const TimezonePreferencesPage({Key? key, required this.groupPrefsMode}) : super(key: key);

  @override
  State<TimezonePreferencesPage> createState() => _TimezonePreferencesPageState();
}

class _TimezonePreferencesPageState extends State<TimezonePreferencesPage> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  List<String> locations = <String>[];
  String? _selectedLocation;

  @override
  void initState() {
    locations = timeZoneDatabase.locations.values
        .map((e) =>
            '${e.name.split('/').join(', ')} (${timeZoneDatabase.locations.values.first.zones.last.abbreviation} ${Duration(milliseconds: e.zones.last.offset).inHours}:00)')
        .toList();

    final index = locations.indexWhere((item) =>
        item.toLowerCase().contains(context.read<GroupPreferencesBloc>().state.data.timezone.toLowerCase()));

    if (!index.isNegative) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _itemScrollController.scrollTo(index: index, duration: const Duration(milliseconds: 300));
      });

      _selectedLocation = locations[index];
    }

    super.initState();
  }

  void _onErrorHandler(GroupPreferencesState state) {
    context.showErrorBar(
        content: Text(state.data.error?.error.toString() ?? ''), position: FlashPosition.top);
  }

  void _onUpdateHandler(GroupPreferencesState state) {
    if (widget.groupPrefsMode == GroupPrefsMode.flow) {
      context.router.push(NicknamePreferencesRoute(groupPrefsMode: GroupPrefsMode.flow));
    } else {
      context.router.pop();
    }
  }

  void _onChangeListener(BuildContext context, GroupPreferencesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      updated: _onUpdateHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        title: LocalizedTexts.groupPreferences.translation,
        leading: const BackButtonHexagon(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28.0),
            BlocListener<GroupPreferencesBloc, GroupPreferencesState>(
              listenWhen: (prev, cur) => context.router.current.name == TimezonePreferencesRoute.name,
              listener: _onChangeListener,
              child: MainContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalizedTexts.whatIsYourTimezone,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ).tr(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SearchField(
                        hintText: LocalizedTexts.searchTimezone.translation,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.greyLabel,
                        ),
                        onChanged: _onSearch),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 28.0,
            ),
            Expanded(
              child: ScrollablePositionedList.separated(
                itemScrollController: _itemScrollController,
                itemCount: locations.length,
                itemBuilder: (BuildContext context, index) {
                  final item = locations[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AppChoiceChip(
                      label: item,
                      selected: _selectedLocation == item,
                      value: item,
                      onSelected: onSelected,
                      textAlign: TextAlign.left,
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
                  OrangeButton(
                    onPressedHandler: _selectedLocation == null ? null : _onNextPressedHandler,
                    child: const Text(LocalizedTexts.next).tr(),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
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
