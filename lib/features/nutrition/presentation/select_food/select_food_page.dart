import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/back_button_hexagon.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/dishes_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorites_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/selected_items_label.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/under_appbar_container.dart';

class SelectFoodPage extends StatefulWidget {
  const SelectFoodPage({Key? key}) : super(key: key);

  @override
  State<SelectFoodPage> createState() => _SelectFoodPageState();
}

class _SelectFoodPageState extends State<SelectFoodPage> {
  @override
  void initState() {
    context.read<SelectFoodBloc>().add(const SelectFoodEvent.fetchFavorites());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        leading: const BackButtonHexagon(),
        title: '${LocalizedTexts.log.tr()} lunch',
        actions: const [SelectedItemsLabel()],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              UnderAppBarContainer(),
              Flexible(
                child: TabBarView(
                  children: [
                    FavoriteList(),
                    DishesList(),
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
