import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/empty_list_widget.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorite_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/footer_overlay.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/list_filters.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class FavoriteList extends StatefulWidget {
  final MealCategory? mealCategory;

  const FavoriteList({
    super.key,
    required this.mealCategory,
  });

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> with AutomaticKeepAliveClientMixin {
  @override
  bool wantKeepAlive = true;

  @override
  void initState() {
    const AnalyticsEventService().logEvent(eventName: AnalyticsEvents.selectFoodScreenMyFavorites);
    super.initState();
  }

  Future<void> _onRefresh() async {
    return context.read<SelectFoodBloc>().add(SelectFoodEvent.fetchFavorites(_defaultMealCategory));
  }

  String get _defaultMealCategory => widget.mealCategory?.originalValue ?? '';

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SelectFoodBloc, SelectFoodState>(
          builder: (BuildContext context, state) {
            return state.maybeMap(
              error: (errorState) {
                final error = errorState.fetchError;

                return Center(
                  child: ErrorScreen(
                    error: error,
                    onButtonPressed: () => context
                        .read<SelectFoodBloc>()
                        .add(SelectFoodEvent.fetchFavorites(_defaultMealCategory)),
                  ),
                );
              },
              selectFood: (selectFoodState) {
                final String title = selectFoodState.hasOneSelectedMealCategory
                    ? '${LocalizedTexts.my.tr()} ${selectFoodState.selectedMealCategories[0].name}'
                    : LocalizedTexts.myFavorites.tr();

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListFilters(
                        title: title,
                        mealsList: selectFoodState.mealFavoritesCategories.toList(),
                        onConfirmed: _onConfirmed,
                      ),
                      selectFoodState.favorites.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: EmptyListWidget(
                                type: EmptyListType.myFavorites,
                                typeText: title,
                              ),
                            )
                          : Expanded(
                              child: RefreshIndicator(
                                onRefresh: _onRefresh,
                                child: ListView.separated(
                                  itemCount: selectFoodState.favorites.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return FavoriteListItem(
                                      foodItem: selectFoodState.favorites[index],
                                    );
                                  },
                                  separatorBuilder: (_, __) {
                                    return const Divider(
                                      height: 1,
                                      color: AppColors.blueLighter,
                                    );
                                  },
                                ),
                              ),
                            ),
                      state.selectedFavoritesItemsLength > 0
                          ? FooterOverlay()
                          : const SizedBox.shrink()
                    ],
                  ),
                );
              },
              loading: (state) => const Expanded(child: Loader()),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }

  void _onConfirmed(List<MealCategoryFilter> list) =>
      context.read<SelectFoodBloc>().add(SelectFoodEvent.filterFavorites(list));
}
