import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/dishes_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorites_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/selected_items_label.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/under_appbar_container.dart';

class SelectFoodPage extends StatelessWidget {
  final String mealCategory;

  const SelectFoodPage({
    super.key,
    required this.mealCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: '${LocalizedTexts.log.translation} $mealCategory',
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
