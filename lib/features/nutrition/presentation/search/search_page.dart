import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_app_bar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list.dart';

class SearchPage extends StatefulWidget {
  final void Function(SearchItem item) onItemTap;
  final SearchMode? mode;

  const SearchPage({
    super.key,
    required this.onItemTap,
    this.mode,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? currentTab = '';

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(const SearchEvent.resetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenOffRegular,
      appBar: SearchAppBar(
        mode: widget.mode,
        onTabChanged: (value) => _onTabChanged(value),
      ),
      body: SafeArea(
        child: SearchResultList(
          selectedTab: currentTab,
          onItemTap: widget.onItemTap,
          onRecentSearchItemTap: (item) {
            context.read<SearchBloc>().add(
                  SearchEvent.search(
                    item,
                    mode: currentTab,
                  ),
                );
          },
        ),
      ),
    );
  }

  _onTabChanged(String? value) {
    setState(() {
      currentTab = value;
    });
  }
}
