import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_empty_result.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list_item.dart';

class SearchResultList extends StatefulWidget {
  const SearchResultList({Key? key}) : super(key: key);

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, state) {
      return state.maybeMap(
        searchResult: (itemsState) {
          return itemsState.items.isEmpty
              ? const SearchEmptyResult()
              : ListView.builder(
                  itemCount: itemsState.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = itemsState.items[index];

                    return SearchResultListItem(item: item);
                  },
                );
        },
        loading: (_) => const SizedBox(height: 240, child: Loader()),
        orElse: () => const SizedBox.shrink(),
      );
    });
  }
}
