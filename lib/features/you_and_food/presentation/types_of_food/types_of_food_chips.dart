import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class TypesOfFoodChips extends StatefulWidget {
  const TypesOfFoodChips({Key? key}) : super(key: key);

  @override
  State<TypesOfFoodChips> createState() => _TypesOfFoodChipsState();
}

class _TypesOfFoodChipsState extends State<TypesOfFoodChips> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final width = constraints.maxWidth / 2 - 5;
      return Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          SizedBox(
            width: width,
            child: AppChoiceChip(
              label: 'Beef',
              selected: true,
              value: 2,
              onSelected: (int value) {},
            ),
          ),
          SizedBox(
            width: width,
            child: AppChoiceChip(
              label: 'Pork',
              selected: true,
              value: 1,
              onSelected: (int value) {},
            ),
          ),
          SizedBox(
            width: width,
            child: AppChoiceChip(
              label: 'Eggs',
              selected: false,
              value: 1,
              onSelected: (int value) {},
            ),
          ),
        ],
      );
    });
  }
}
