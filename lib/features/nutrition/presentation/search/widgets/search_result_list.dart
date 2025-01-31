import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/recipe_button_layout.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_empty_result.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_list_title_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_grid_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorites_list.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

import '../../../application/select_food/select_food_bloc.dart';

class SearchResultList extends StatefulWidget {
  final Function(String) onRecentSearchItemTap;
  final void Function(SearchItem item) onItemTap;
  final String? selectedTab;
  final SearchMode mode;
  final MealCategory mealCategory;

  const SearchResultList({
    super.key,
    required this.onRecentSearchItemTap,
    this.selectedTab,
    required this.mode,
    required this.mealCategory,
    required this.onItemTap,
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
    context
        .read<SelectFoodBloc>()
        .add(SelectFoodEvent.fetchFavorites(widget.mealCategory.originalValue));
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

  @override
  Widget build(BuildContext context) {
    if (widget.selectedTab != 'recipe') selectedLayout = SearchListLayout.list;

    if (widget.selectedTab == 'favorite') {
      return BlocBuilder<SearchBloc, SearchState>(builder: (BuildContext context, state) {
        return state.maybeWhen(
            loading: (state) => const SizedBox(height: 250, child: Loader()),
            orElse: () => FavoriteList(mealCategory: widget.mealCategory));
      });
    }

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
                        if (widget.selectedTab == 'recipe')
                          RecipeButtonLayout(
                            selectedLayout: selectedLayout,
                            onSelectLayoutTap: _onSelectLayoutTap,
                          ),
                        if (selectedLayout == SearchListLayout.list)
                          _ListLayout(onItemTap: widget.onItemTap, itemsState: itemsState),
                        if (selectedLayout == SearchListLayout.detailed)
                          _DetailedLayout(onItemTap: widget.onItemTap, itemsState: itemsState),
                      ],
                    ),
                  );
          },
          initial: (initialState) {
            final recentSearchList = state.data.recentSearch ?? <String>[];

            return Column(
              children: [
                SearchListTitleItem(
                  text: LocalizedTexts.recentSearch.tr(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: recentSearchList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final item = recentSearchList[index];
                      final itemType = item.length > 1
                          ? SearchItemTypes.values.firstWhere((e) => e.toString() == item[1],
                              orElse: () => SearchItemTypes.recent)
                          : SearchItemTypes.recent;

                      return SearchResultListItem(
                        item: SearchItem(
                          id: index.toString(),
                          name: item,
                          type: itemType,
                        ),
                        onTap: (SearchItem item) {
                          widget.onRecentSearchItemTap(item.name);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
          error: (errorState) {
            final error = errorState.data.error;
            return Center(
              child: ErrorScreen(
                error: error!,
              ),
            );
          },
          loading: (_) => const SizedBox(height: 250, child: Loader()),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _DetailedLayout extends StatelessWidget {
  const _DetailedLayout({
    required this.onItemTap,
    required this.itemsState,
  });

  final void Function(SearchItem) onItemTap;
  final SearchState itemsState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
            onTap: onItemTap,
          );
        },
      ),
    );
  }
}

class _ListLayout extends StatelessWidget {
  const _ListLayout({
    required this.onItemTap,
    required this.itemsState,
  });

  final void Function(SearchItem) onItemTap;
  final SearchState itemsState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemsState.data.items.length,
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
          onTap: onItemTap,
        );
      },
    );
  }
}
