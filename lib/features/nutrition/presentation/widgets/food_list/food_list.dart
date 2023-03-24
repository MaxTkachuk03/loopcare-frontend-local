import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_item/food_item.dart';

class FoodList extends StatelessWidget {
  final List<dynamic> list; // TODO: create model for item

  const FoodList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

        // TODO: change to real list
        return const FoodItem(
          title: 'Test',
          subtitle: 'Test subtitle',
          serving: '60 g',
          nutritionValue: '201',
        );
      },
    );
  }
}
