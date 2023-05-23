import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/dishes_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorites_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/selected_items_label.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/under_appbar_container.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_extensions.dart';

class SelectFoodPage extends StatelessWidget {
  final String mealCategory;

  const SelectFoodPage({
    super.key,
    required this.mealCategory,
  });

  String _appBarTitle (BuildContext context) {
    final state = context.read<MealsBloc>().state;

    final date = state.getCurrentDate.isoStringWithoutTime !=
        DateTime.now().isoStringWithoutTime
        ? state.getCurrentDate.shortDate
        : 'today';

    return '${mealCategory.capitalizeOnlyFirstLetter()} $date';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: _appBarTitle(context),
        actions: const [SelectedItemsLabel()],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const UnderAppBarContainer(),
              Flexible(
                child: TabBarView(
                  children: [
                    const FavoriteList(),
                    DishesList(mealCategory: mealCategory),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
