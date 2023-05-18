import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/serving_size/serving_size.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/serving_list_item/serving_list_item.dart';

class ServingList extends StatefulWidget {
  const ServingList({Key? key}) : super(key: key);

  @override
  State<ServingList> createState() => _ServingListState();
}

class _ServingListState extends State<ServingList> {
  final TextEditingController _amountFieldController = TextEditingController();

  void _onListItemPressedHandler(ServingSize item) {
    _amountFieldController.text = item.numberOfUnits.round().toString();
    context
        .read<FoodItemServingsBloc>()
        .add(FoodItemServingsEvent.setSelectedFoodItemServing(item));
  }

  @override
  void dispose() {
    _amountFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FoodItemServingsBloc, FoodItemServingsState>(
      listenWhen: _foodServingListenWhen,
      listener: _foodServingListener,
      child: BlocBuilder<FoodItemServingsBloc, FoodItemServingsState>(
        builder: (BuildContext context, state) {
          return state.maybeMap(
              orElse: () => const SizedBox(),
              loading: (_) => const Loader(),
              foodItemServings: (foodItemServingsState) {
                return ListView.builder(
                  itemCount: foodItemServingsState.servingsIList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final ServingSize listItem =
                        foodItemServingsState.servingsIList[index];
                    final isSelected =
                        foodItemServingsState.selectedServingItem?.servingId ==
                            listItem.servingId;

                    return ServingListItem(
                      item: listItem,
                      onPressed: _onListItemPressedHandler,
                      isSelected: isSelected,
                      inputController: _amountFieldController,
                    );
                  },
                );
              });
        },
      ),
    );
  }

  void _foodServingListener(BuildContext context, FoodItemServingsState state) {
    final initialValue = context
            .read<FoodItemServingsBloc>()
            .state
            .selectedServingItem
            ?.numberOfUnits
            .round() ??
        '1';

    _amountFieldController.text = '$initialValue';
  }

  bool _foodServingListenWhen(
      FoodItemServingsState previous, FoodItemServingsState current) {
    return previous is Loading && current is FoodItemServings;
  }
}
