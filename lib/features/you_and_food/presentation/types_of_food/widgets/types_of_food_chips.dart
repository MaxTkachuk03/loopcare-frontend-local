import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class TypesOfFoodChips extends StatefulWidget {
  const TypesOfFoodChips({Key? key}) : super(key: key);

  @override
  State<TypesOfFoodChips> createState() => _TypesOfFoodChipsState();
}

class _TypesOfFoodChipsState extends State<TypesOfFoodChips> {
  @override
  void initState() {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.fetchFoodPrefsTypes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final width = constraints.maxWidth / 2 - 5;
      return BlocBuilder<YouAndFoodBloc, YouAndFoodState>(
        builder: (BuildContext context, state) {
          final selectedHates = state.selectedHates;

          return Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: state.foodTypes
                .map(
                  (e) => SizedBox(
                    width: width,
                    child: AppChoiceChip(
                      label: e.name,
                      selected: selectedHates.contains(e.id),
                      value: e.id,
                      onSelected: _onSelected,
                    ),
                  ),
                )
                .toList(),
          );
        },
      );
    });
  }

  void _onSelected(int value) {
    context.read<YouAndFoodBloc>().add(YouAndFoodEvent.setHates(value));
  }
}
