import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';

import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item_types.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_empty_result.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_list_title_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list_item.dart';

class SearchResultList extends StatefulWidget {
  final void Function(SearchItem item) onItemTap;
  final Function(String) onRecentSearchItemTap;

  const SearchResultList({
    Key? key,
    required this.onItemTap,
    required this.onRecentSearchItemTap,
  }) : super(key: key);

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          searchResult: (itemsState) {
            return itemsState.data.items.isEmpty
                ? const SearchEmptyResult()
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: itemsState.data.items.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == itemsState.data.items.length) {
                        if (itemsState.data.loadingMore) {
                          return const Loader();
                        }

                        return const SizedBox.shrink();
                      }
                      final item = itemsState.data.items[index];

                      return SearchResultListItem(
                        item: item,
                        onTap: widget.onItemTap,
                      );
                    },
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
                      text: LocalizedTexts.recentSearch.translation,
                    );
                  }

                  final item = recentSearchList[index];

                  return SearchResultListItem(
                    item: SearchItem(
                      id: index.toString(),
                      name: item,
                      type: SearchItemTypes.recent,
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
                smallVersion: true,
                error: error,
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
