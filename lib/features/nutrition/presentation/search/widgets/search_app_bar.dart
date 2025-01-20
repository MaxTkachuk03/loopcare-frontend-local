import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_underlined_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/function_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SearchMode? mode;
  final TextEditingController searchController;
  final void Function(String? tabName)? onTabChanged;

  const SearchAppBar(
      {super.key,
      this.mode,
      this.onTabChanged,
      required this.searchController});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);
}

class _SearchAppBarState extends State<SearchAppBar>
    with TickerProviderStateMixin {
  String? searchMode = '';
  late TabController _tabController;
  late List<String> tabs;
  late final MealCategory? mealCategory;
  DateTime logDay = DateTime.now();

  SearchMode get searchType => SearchMode.values.toList()[_tabController.index];

  @override
  initState() {
    super.initState();

    var mode = widget.mode;
    if (mode != null) {
      tabs = <String>[mode.label];
    } else {
      tabs = SearchMode.values
          .where((e) => e.label != SearchMode.dish.label)
          .map((e) => e.label)
          .toList();
    }

    _tabController = TabController(length: tabs.length, vsync: this)
      ..addListener(_tabsChangeListener);

    if (mode == null) searchMode = searchType.searchModeValue;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (widget.onTabChanged != null) {
          widget.onTabChanged!(searchMode);
        }
      },
    );

    mealCategory = context.read<MealsBloc>().state.data.currentMealCategory;
    logDay = context.read<MealsBloc>().state.data.currentDate!;
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.removeListener(_tabsChangeListener);
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greenOffRegular,
      child: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CustomFilledIconButton.leadingGreenLighter(),
                ),
                const Spacer(),
                CustomText.w600(
                  "${mealCategory!.title} ${logDay.shortDate}",
                  style: context.textTheme.titleLarge,
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomUnderlinedTabBar(
                          tabs: tabs.map((e) => Tab(text: e)).toList(),
                          tabController: _tabController,
                          tabAlignment: TabAlignment.center,
                          labelColor: AppColors.blueDarker,
                          unselectedLabelColor: AppColors.blueDarker,
                        ),
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: AppColors.greenLighter,
                              borderRadius: BorderRadius.circular(4.0)),
                          child: TextButton.icon(
                            onPressed: () {
                              context.router
                                  .pushNamed(AppRoutes.barcodeScanner);
                            },
                            icon: const ImageIcon(AppIcons.scan,
                                color: AppColors.blueDarker),
                            label: CustomText.w400(LocalizedTexts.scan.tr()),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              minimumSize: const Size(0, 0),
                              foregroundColor: AppColors.blueDarker,
                              textStyle: context.textTheme.bodyMedium,
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CustomTextField.search(
                      controller: widget.searchController,
                      onCleared: _onCleared,
                      onChanged: _onTextChange
                          .withDebounce(const Duration(milliseconds: 500)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tabsChangeListener() {
    if (_tabController.indexIsChanging) {
      context.read<SearchBloc>().add(SearchEvent.resetData(mode: searchType));
      String? selectedMode = searchType.searchModeValue;
      searchMode = selectedMode;
      if (widget.onTabChanged != null) {
        widget.onTabChanged!(searchMode);
      }

      final filters = [searchMode, widget.mode?.searchModeValue].toString();
      const AnalyticsEventService().logEvent(
        eventName: AnalyticsEvents.performedSearch,
        parameters: {
          AnalyticsParameters.value: widget.searchController.text,
          AnalyticsParameters.filters:
              widget.mode == null ? searchMode : filters,
        },
      );

      context.read<SearchBloc>().add(
            SearchEvent.search(
              widget.searchController.text,
              mode: searchMode,
              filteredMode: widget.mode?.searchModeValue,
            ),
          );
    }
  }

  void _onTextChange(String value) {
    if (value.isEmpty) {
      context.read<SearchBloc>().add(SearchEvent.resetData(mode: searchType));
      return;
    }

    final filters = [searchMode, widget.mode?.searchModeValue].toString();
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.performedSearch,
      parameters: {
        AnalyticsParameters.value: widget.searchController.text,
        AnalyticsParameters.filters: widget.mode == null ? searchMode : filters,
      },
    );

    context.read<SearchBloc>().add(
          SearchEvent.search(
            value,
            mode: searchMode,
            filteredMode: widget.mode?.searchModeValue,
          ),
        );
  }

  void _onCleared() =>
      context.read<SearchBloc>().add(SearchEvent.resetData(mode: searchType));
}
