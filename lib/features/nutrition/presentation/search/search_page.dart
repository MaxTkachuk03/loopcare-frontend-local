import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_app_bar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  final void Function(SearchItem item) onItemTap;
  final SearchMode? mode;

  const SearchPage({super.key, required this.onItemTap, this.mode});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? currentTab = '';
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(const SearchEvent.resetData());
    const AnalyticsEventService()
        .logEvent(eventName: AnalyticsEvents.searchScreenOpened);
  }

  Future<bool> _onPreviousPage(bool e) async {
    const AnalyticsEventService()
        .logEvent(eventName: AnalyticsEvents.searchScreenClosed);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (e, _) => _onPreviousPage,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.greenOffRegular,
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
        ),
        backgroundColor: AppColors.greenLightest,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchAppBar(
              onItemTap: widget.onItemTap,
              selectedTab: currentTab,
              mode: widget.mode,
              onTabChanged: _onTabChanged,
              searchController: _searchTextController,
            ),
            Expanded(
              child: SearchResultList(
                searchController: _searchTextController,
                onRecentSearchItemTap: (item) {
                  setState(() {
                    context
                        .read<SearchBloc>()
                        .add(SearchEvent.search(item, mode: currentTab));
                    _searchTextController.text = item;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTabChanged(String? value) {
    setState(() {
      currentTab = value;
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}
