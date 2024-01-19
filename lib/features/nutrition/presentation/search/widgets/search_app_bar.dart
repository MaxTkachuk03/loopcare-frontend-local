import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_underlined_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SearchMode? mode;
  final void Function(String? tabName)? onTabChanged;

  const SearchAppBar({
    super.key,
    this.mode,
    this.onTabChanged,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);
}

class _SearchAppBarState extends State<SearchAppBar> with TickerProviderStateMixin {
  String? searchMode = '';
  final TextEditingController _searchTextController = TextEditingController();
  late TabController _tabController;
  late List<String> tabs;

  SearchMode get searchType => SearchMode.values.toList()[_tabController.index];

  @override
  initState() {
    super.initState();

    var mode = widget.mode;
    if (mode != null) {
      tabs = <String>[mode.label];
    } else {
      tabs =
          SearchMode.values.where((e) => e.label != SearchMode.favorite.label).map((e) => e.label).toList();
    }

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(_tabsChangeListener);
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
    return DefaultTabController(
      length: tabs.length,
      child: CustomAppBar.green(
        leading: CustomFilledIconButton.leadingGreenLighter(),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(56, 8, 8, 8),
              child: BlocListener<SearchBloc, SearchState>(
                listenWhen: (prev, cur) =>
                    prev.data.searchParameters.query != cur.data.searchParameters.query,
                listener: _searchQueryListener,
                child: CustomTextField.search(
                  controller: _searchTextController,
                  onCleared: _onCleared,
                  onChanged: _onTextChange,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 25, right: 25),
            child: CustomUnderlinedTabBar(
              tabs: tabs.map((e) => Tab(text: e)).toList(),
              tabController: _tabController,
              tabAlignment: TabAlignment.center,
              labelColor: AppColors.blueDarker,
              unselectedLabelColor: AppColors.blueDarker,
            ),
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

      context.read<SearchBloc>().add(
            SearchEvent.search(
              _searchTextController.text,
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

    context.read<SearchBloc>().add(
          SearchEvent.search(
            value,
            mode: searchMode,
            filteredMode: widget.mode?.searchModeValue,
          ),
        );
  }

  void _onCleared() => context.read<SearchBloc>().add(SearchEvent.resetData(mode: searchType));

  void _searchQueryListener(BuildContext context, SearchState state) {
    _searchTextController.text = state.data.searchParameters.query ?? '';
    _searchTextController.selection = TextSelection.collapsed(offset: _searchTextController.text.length);
  }
}
