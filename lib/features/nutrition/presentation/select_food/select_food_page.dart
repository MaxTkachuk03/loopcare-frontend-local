import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/dishes_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/favorites_list.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/selected_items_label.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/under_appbar_container.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

class SelectFoodPage extends StatefulWidget {
  final String mealCategory;

  const SelectFoodPage({
    super.key,
    required this.mealCategory,
  });

  @override
  State<SelectFoodPage> createState() => _SelectFoodPageState();
}

class _SelectFoodPageState extends State<SelectFoodPage> with TickerProviderStateMixin {
  late TabController _tabController;

  String _appBarTitle(BuildContext context) {
    final state = context.read<MealsBloc>().state;

    final date = state.data.currentDateTime.isoStringWithoutTime != DateTime.now().isoStringWithoutTime
        ? state.data.currentDateTime.shortDate
        : 'today';

    return '${widget.mealCategory.capitalizeOnlyFirstLetter()} $date';
  }

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: 2,
      animationDuration: const Duration(milliseconds: 100),
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: _appBarTitle(context),
        leading: CustomFilledIconButton.leadingGreenLighter(),
        actions: const [SelectedItemsLabel()],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: UnderAppBarContainer(
            tabController: _tabController,
          ),
        ),
      ),
      body: CustomSafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FavoriteList(mealCategory: widget.mealCategory),
                    DishesList(mealCategory: widget.mealCategory),
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
