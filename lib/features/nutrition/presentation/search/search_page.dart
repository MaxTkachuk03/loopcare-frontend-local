import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_app_bar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list.dart';

import '../../application/meals/meals_bloc.dart';
import '../../domain/select_serving/meal_category.dart';

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
  late MealCategory mealCategory;
  DateTime loggedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    final mealsBlocState = context.read<MealsBloc>().state.data;
    loggedDate = mealsBlocState.currentDate!;
    mealCategory = mealsBlocState.currentMealCategory!;

    context
        .read<SearchBloc>()
        .add(SearchEvent.getRecentLogged(mealCategory.originalValue, SearchMode.food));

    const AnalyticsEventService().logEvent(eventName: AnalyticsEvents.searchScreenOpened);
  }

  Future<bool> _onPreviousPage(bool e) async {
    const AnalyticsEventService().logEvent(eventName: AnalyticsEvents.searchScreenClosed);
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
              selectedTab: currentTab,
              mode: widget.mode,
              mealCategory: mealCategory,
              onTabChanged: _onTabChanged,
              searchController: _searchTextController,
              loggedDate: loggedDate.shortDate,
            ),
            Expanded(
              child: CustomSafeArea(
                child: SearchResultList(
                  onItemTap: widget.onItemTap,
                  mode: widget.mode ?? SearchMode.food,
                  mealCategory: mealCategory,
                  selectedTab: currentTab,
                  onRecentSearchItemTap: (item) {
                    setState(() {
                      context.read<SearchBloc>().add(SearchEvent.search(item, mode: currentTab));
                      _searchTextController.text = item;
                    });
                  },
                ),
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
