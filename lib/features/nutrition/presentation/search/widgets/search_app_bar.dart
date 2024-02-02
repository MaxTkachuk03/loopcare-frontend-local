import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_underlined_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/function_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final SearchMode? mode;
  final TextEditingController searchController;
  final void Function(String? tabName)? onTabChanged;

  const SearchAppBar({super.key, this.mode, this.onTabChanged, required this.searchController});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);
}

class _SearchAppBarState extends State<SearchAppBar> with TickerProviderStateMixin {
  String? searchMode = '';
  late TabController _tabController;
  late List<String> tabs;
  Timer? _debounce;

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

    _tabController = TabController(length: tabs.length, vsync: this)..addListener(_tabsChangeListener);

    if (mode == null) searchMode = searchType.searchModeValue;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (widget.onTabChanged != null) {
          widget.onTabChanged!(searchMode);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.removeListener(_tabsChangeListener);
    _tabController.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: CustomFilledIconButton.leadingGreenLighter(),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppColors.greenRegular,
        title: CustomTextField.search(
          controller: widget.searchController,
          onCleared: _onCleared,
          onChanged: _onTextChange.withDebounce(const Duration(milliseconds: 500)),
        ),
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

    context
        .read<SearchBloc>()
        .add(SearchEvent.search(value, mode: searchMode, filteredMode: widget.mode?.searchModeValue));
  }

  void _onCleared() => context.read<SearchBloc>().add(SearchEvent.resetData(mode: searchType));
}
