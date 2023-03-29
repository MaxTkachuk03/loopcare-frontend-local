import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/serving_list_item/serving_list_item.dart';

class ServingList extends StatefulWidget {
  const ServingList({Key? key}) : super(key: key);

  @override
  State<ServingList> createState() => _ServingListState();
}

class _ServingListState extends State<ServingList> {
  final TextEditingController _amountFieldController = TextEditingController();

  void _onListItemPressedHandler(FoodItemServing item) {
    _amountFieldController.text = item.numberOfUnits.round().toString();
    context
        .read<FoodItemServingsBloc>()
        .add(FoodItemServingsEvent.setSelectedFoodItemServing(item));
  }

  @override
  void initState() {
    final initialValue = context
            .read<FoodItemServingsBloc>()
            .state
            .selectedServingItem
            ?.numberOfUnits ??
        '1';

    _amountFieldController.text = '$initialValue';
    super.initState();
  }

  @override
  void dispose() {
    _amountFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodItemServingsBloc, FoodItemServingsState>(
        builder: (BuildContext context, state) {
      if (state.servingsIList.isEmpty) return const SizedBox();

      return ListView.builder(
        itemCount: state.servingsIList.length,
        itemBuilder: (BuildContext context, int index) {
          final FoodItemServing listItem = state.servingsIList[index];
          final isSelected =
              state.selectedServingItem?.servingId == listItem.servingId;

          return ServingListItem(
            item: listItem,
            onPressed: _onListItemPressedHandler,
            isSelected: isSelected,
            inputController: _amountFieldController,
          );
        },
      );
    });
  }
}
