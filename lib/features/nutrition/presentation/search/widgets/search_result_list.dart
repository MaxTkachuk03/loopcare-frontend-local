import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_list_title_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorites_list.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SearchResultList extends StatefulWidget {
  final Function(String) onRecentSearchItemTap;
  final TextEditingController searchController;
  final String? selectedTab;

  const SearchResultList({
    super.key,
    required this.onRecentSearchItemTap,
    required this.searchController,
    this.selectedTab,
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
  late final MealCategory? mealCategory;

  @override
  void initState() {
    _scrollController.addListener(_onScrollChangeListener);
    mealCategory = context.read<MealsBloc>().state.data.currentMealCategory;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChangeListener);
    _scrollController.dispose();

    super.dispose();
  }

  void _onScrollChangeListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        final recentSearchList = state.data.recentSearch ?? <String>[];

        if (widget.selectedTab == 'favorite' &&
            widget.searchController.text.isEmpty) {
          return FavoriteList(mealCategory: mealCategory);
        }

        if (recentSearchList.isNotEmpty &&
            widget.searchController.text.isEmpty) {
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
                  ? SearchItemTypes.values.firstWhere(
                      (e) => e.toString() == item[1],
                      orElse: () => SearchItemTypes.recent)
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
    );
  }
}
