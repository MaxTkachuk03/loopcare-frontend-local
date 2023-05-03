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
  const SearchAppBar({
    Key? key,
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

  final List<String> tabs = SearchMode.values.map((e) => e.label).toList();

  @override
  initState() {
    super.initState();

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
      length: 4,
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
                onChanged: _onTextChange,
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
    setState(
      () {
        if (_tabController.indexIsChanging) {
          String? mode =
              SearchMode.values.toList()[_tabController.index].searchModeValue;
          searchMode = mode;

          context.read<SearchBloc>().add(
                SearchEvent.search(
                  searchText,
                  mode: searchMode,
                ),
              );
        }
      },
    );
  }

  void _onTextChange(String value) {
    setState(
      () {
        searchText = value;

        context.read<SearchBloc>().add(
              SearchEvent.search(
                searchText,
                mode: searchMode,
              ),
            );
      },
    );
  }
}
