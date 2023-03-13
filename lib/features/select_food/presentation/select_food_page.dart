import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/select_food/presentation/widgets/my_list.dart';
import 'package:loopcare_frontend/features/select_food/presentation/widgets/selected_items_label.dart';
import 'package:loopcare_frontend/features/select_food/presentation/widgets/under_appbar_container.dart';

class SelectFoodPage extends StatelessWidget {
  const SelectFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(context).textTheme.headline5?.copyWith(
              color: AppColors.white,
            ),
        title: Text('Dinner 20 February'),
        backgroundColor: AppColors.blueAppBar,
        actions: [const SelectedItemsLabel()],
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
                    MyList(
                      title: LocalizedTexts.myLunchFavorites.tr(),
                      list: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
                    ),
                    MyList(
                      title: LocalizedTexts.myLunchDishes.tr(),
                      list: [1, 2, 3],
                    ),
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
