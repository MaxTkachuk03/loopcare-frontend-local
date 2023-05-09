import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_tab_bar.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SearchMode? mode;
  final String? selectedRecentSearchItem;

  const SearchAppBar({
    Key? key,
    this.mode,
    this.selectedRecentSearchItem,
  }) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);
}

class _SearchAppBarState extends State<SearchAppBar>
    with TickerProviderStateMixin {
  String searchText = '';
  String? searchMode = '';
  final TextEditingController _searchTextController = TextEditingController();
  late TabController _tabController;
  late List<String> tabs;

  @override
  initState() {
    super.initState();
    var mode = widget.mode;
    if (mode != null) {
      tabs = <String>[mode.label];
    } else {
      tabs = SearchMode.values
          .where((e) => e.label != SearchMode.favorite.label)
          .map((e) => e.label)
          .toList();
    }

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(_tabsChangeListener);
    _searchTextController.addListener(_onTextChange);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.removeListener(_tabsChangeListener);
    _tabController.dispose();
    _searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedRecentSearchItem = widget.selectedRecentSearchItem;
    if (selectedRecentSearchItem != null) {
      _searchTextController.text = selectedRecentSearchItem;
    }
    return DefaultTabController(
      length: tabs.length,
      child: BlueAppBar(
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 8, 0, 8),
              child: Field(
                autofocus: true,
                contentPadding: const EdgeInsets.only(left: 12),
                hintText: LocalizedTexts.searchHint.translation,
                controller: _searchTextController,
                isClearField: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => {
                Navigator.pop(context),
              },
              icon: const Icon(Icons.close, color: AppColors.white),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 8),
                  child: Text(
                    LocalizedTexts.searchFilterIn.translation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ),
                UnderlinedTabBar(
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                  tabController: _tabController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tabsChangeListener() {
    if (_tabController.indexIsChanging) {
      String? selectedMode =
          SearchMode.values.toList()[_tabController.index].searchModeValue;
      searchMode = selectedMode;

      context.read<SearchBloc>().add(
            SearchEvent.search(
              searchText,
              mode: searchMode,
              filteredMode: widget.mode?.searchModeValue,
            ),
          );
    }
  }

  void _onTextChange() {
    searchText = _searchTextController.text;

    if (searchText.isEmpty) {
      context.read<SearchBloc>().add(const SearchEvent.resetData());
    }

    context.read<SearchBloc>().add(
          SearchEvent.search(
            searchText,
            mode: searchMode,
            filteredMode: widget.mode?.searchModeValue,
          ),
        );
  }
}
