import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_empty_result.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_list_title_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_grid_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list_item.dart';

class SearchResultList extends StatefulWidget {
  final void Function(SearchItem item) onItemTap;
  final Function(String) onRecentSearchItemTap;
  final String? selectedTab;

  const SearchResultList({
    super.key,
    required this.onItemTap,
    required this.onRecentSearchItemTap,
    required this.selectedTab,
  });

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

enum SearchListLayout {
  detailed,
  list,
}

class _SearchResultListState extends State<SearchResultList> {
  final ScrollController _scrollController = ScrollController();
  SearchListLayout selectedLayout = SearchListLayout.list;

  @override
  void initState() {
    _scrollController.addListener(_onScrollChangeListener);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChangeListener);
    _scrollController.dispose();

    super.dispose();
  }

  void _onScrollChangeListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
      final searchBloc = context.read<SearchBloc>();
      final searchState = searchBloc.state;

      searchState.mapOrNull(
        searchResult: (state) {
          searchBloc.add(
            SearchEvent.paginatedSearch(
              state.data.searchParameters.query ?? '',
              mode: state.data.searchParameters.mode,
              filteredMode: state.data.searchParameters.filteredMode,
              page: (state.data.searchParameters.page ?? 1) + 1,
            ),
          );
        },
      );
    }
  }

  void _onSelectLayoutTap(SearchListLayout value) {
    setState(() {
      selectedLayout = value;
    });
  }

  Widget listLayout(SearchState itemsState) {
    return ListView.separated(
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

        return SearchResultListItem(
          showLeading: false,
          item: item,
          onTap: widget.onItemTap,
        );
      },
      separatorBuilder: (_, __) => const Divider(color: AppColors.blueLighter, height: 1, thickness: 1),
    );
  }

  Widget detailedLayout(SearchState itemsState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
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
                  onPressed: () => _onSelectLayoutTap(SearchListLayout.detailed),
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

  @override
  Widget build(BuildContext context) {
    if (widget.selectedTab != 'recipe') selectedLayout = SearchListLayout.list;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          searchResult: (itemsState) {
            if (itemsState.data.isLoading) {
              return const Loader();
            }

            return itemsState.data.items.isEmpty
                ? const SearchEmptyResult()
                : SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.selectedTab == 'recipe') recipeButtonLayout(),
                        if (selectedLayout == SearchListLayout.list) listLayout(itemsState),
                        if (selectedLayout == SearchListLayout.detailed) detailedLayout(itemsState),
                      ],
                    ),
                  );
          },
          initial: (initialState) {
            var recentSearchList = initialState.data.recentSearch ?? <String>[];

            if (recentSearchList.isNotEmpty) {
              return ListView.builder(
                itemCount: recentSearchList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    // return the header
                    return SearchListTitleItem(
                      text: LocalizedTexts.recentSearch.tr(),
                    );
                  }

                  final item = recentSearchList[index].split('*-*');
                  final itemName = item[0];
                  final itemType = item.length > 1
                      ? SearchItemTypes.values
                          .firstWhere((e) => e.toString() == item[1], orElse: () => SearchItemTypes.recent)
                      : SearchItemTypes.recent;

                  return SearchResultListItem(
                    item: SearchItem(
                      id: index.toString(),
                      name: itemName,
                      type: itemType,
                    ),
                    onTap: (SearchItem item) {
                      widget.onRecentSearchItemTap(item.name);
                    },
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
          error: (errorState) {
            final error = errorState.data.error;

            return Center(
              child: ErrorScreen(
                error: error!,
              ),
            );
          },
          loading: (_) => const SizedBox(height: 240, child: Loader()),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
