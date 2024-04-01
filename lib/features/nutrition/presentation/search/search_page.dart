import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_app_bar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list.dart';

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
    AnalyticsEventService.instance.logEvent(FirebaseEvents.searchScreenOpened);
  }

  Future<bool> _onPreviousPage(BuildContext context) {
    AnalyticsEventService.instance.logEvent(FirebaseEvents.searchScreenClosed);

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onPreviousPage(context),
      child: Scaffold(
        backgroundColor: AppColors.greenOffRegular,
        appBar: SearchAppBar(
          mode: widget.mode,
          onTabChanged: _onTabChanged,
          searchController: _searchTextController,
        ),
        body: CustomSafeArea(
          child: SearchResultList(
            selectedTab: currentTab,
            onItemTap: widget.onItemTap,
            onRecentSearchItemTap: (item) {
              context.read<SearchBloc>().add(SearchEvent.search(item, mode: currentTab));
              _searchTextController.text = item;
            },
          ),
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
