import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_underlined_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/function_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_empty_result.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_grid_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list_item.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SearchMode? mode;
  final TextEditingController searchController;
  final void Function(String? tabName)? onTabChanged;
  final void Function(SearchItem item) onItemTap;
  final String? selectedTab;

  const SearchAppBar(
      {super.key,
      this.mode,
      this.onTabChanged,
      required this.searchController,
      required this.onItemTap,
      this.selectedTab});

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
  SearchListLayout selectedLayout = SearchListLayout.list;

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

  OutlineInputBorder get _borderStyle => const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        color: AppColors.white,
      ));

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    if (widget.selectedTab != 'recipe') selectedLayout = SearchListLayout.list;
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
                  const SizedBox(height: 16.0),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: (height / 2.25) - 16,
                    ),
                    child: Stack(
                      fit: widget.searchController.text.isNotEmpty
                          ? StackFit.expand
                          : StackFit.loose,
                      children: [
                        CustomTextField.search(
                          contentPadding: const EdgeInsets.only(bottom: 4.0),
                          borderStyle: _borderStyle,
                          controller: widget.searchController,
                          onCleared: _onCleared,
                          onChanged: _onTextChange.withDebounce(
                              const Duration(milliseconds: 500)),
                        ),
                        widget.searchController.text.isNotEmpty
                            ? Positioned(
                                top: 42,
                                child: Container(
                                  constraints:
                                      BoxConstraints(maxWidth: width - 40),
                                  foregroundDecoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.greyLight),
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(16.0)),
                                  ),
                                  child: BlocBuilder<SearchBloc, SearchState>(
                                      builder: (BuildContext context, state) {
                                    return state.maybeMap(
                                      searchResult: (itemsState) {
                                        if (itemsState.data.isLoading) {
                                          return const Loader();
                                        }
                    
                                        return itemsState.data.items.isEmpty
                                            ? const SearchEmptyResult()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (widget.selectedTab ==
                                                      'recipe')
                                                    recipeButtonLayout(),
                                                  if (selectedLayout ==
                                                      SearchListLayout.list)
                                                    listLayout(itemsState),
                                                  if (selectedLayout ==
                                                      SearchListLayout
                                                          .detailed)
                                                    detailedLayout(
                                                        itemsState),
                                                ],
                                              );
                                      },
                                      loading: (_) => SizedBox(
                                          height: 250,
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                color: AppColors.greenLighter,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        bottom:
                                                            Radius.circular(
                                                                16.0)),
                                              ),
                                              child: const Loader())),
                                      orElse: () => const SizedBox.shrink(),
                                    );
                                  }),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectLayoutTap(SearchListLayout value) {
    setState(() {
      selectedLayout = value;
    });
  }

  Widget listLayout(SearchState itemsState) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount:
          itemsState.data.items.length < 5 ? itemsState.data.items.length : 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == itemsState.data.items.length) {
          if (itemsState.data.loadingMore) {
            return const Loader();
          }

          return const SizedBox.shrink();
        }

        final islast = itemsState.data.items.length < 5
            ? index == itemsState.data.items.length - 1
            : index == 3;

        final item = itemsState.data.items[index];

        return SearchResultListItem(
          showLeading: false,
          item: item,
          onTap: widget.onItemTap,
          isLast: islast,
          color: AppColors.greenLighter,
        );
      },
    );
  }

  Widget detailedLayout(SearchState itemsState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: itemsState.data.items.length + 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == itemsState.data.items.length) {
            if (itemsState.data.loadingMore) {
              return const Loader();
            }

            return const SizedBox.shrink();
          }
          final item = itemsState.data.items[index];

          return SearchResultGridItem(
            item: item,
            onTap: widget.onItemTap,
          );
        },
      ),
    );
  }

  Widget recipeButtonLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Container(
        width: 114,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.yellowLight),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                child: IconButton(
                  onPressed: () =>
                      _onSelectLayoutTap(SearchListLayout.detailed),
                  iconSize: 16,
                  padding: const EdgeInsets.all(0.0),
                  icon: ImageIcon(
                    AppIcons.detailsLayout,
                    color: (selectedLayout == SearchListLayout.detailed)
                        ? AppColors.blueRegular
                        : AppColors.yellowLight,
                  ),
                ),
              ),
              const VerticalDivider(
                color: AppColors.yellowLight,
                thickness: 1.0,
              ),
              SizedBox(
                child: IconButton(
                  onPressed: () => _onSelectLayoutTap(SearchListLayout.list),
                  iconSize: 16,
                  padding: const EdgeInsets.all(0.0),
                  icon: ImageIcon(
                    AppIcons.listLayout,
                    color: (selectedLayout == SearchListLayout.list)
                        ? AppColors.blueRegular
                        : AppColors.yellowLight,
                  ),
                ),
              ),
            ],
          ),
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
    setState(() {});

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
