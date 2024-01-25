import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class AllergicChips extends StatefulWidget {
  final bool fromLessonComplete;

  const AllergicChips({
    super.key,
    required this.fromLessonComplete,
  });

  @override
  State<AllergicChips> createState() => _AllergicChipsState();
}

class _AllergicChipsState extends State<AllergicChips> {
  @override
  void initState() {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.foodPrefsAllergens());
    super.initState();
  }

  Widget _getCustomChoiceChip({
    required String label,
    required bool selected,
    required FoodPreference value,
  }) {
    if (widget.fromLessonComplete) {
      return CustomChoiceChip.green(
        label: label,
        selected: selected,
        value: value,
        onSelected: _onSelected,
      );
    }
    return CustomChoiceChip.coral(
      label: label,
      selected: selected,
      value: value,
      onSelected: _onSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth / 2 - 5;
        return BlocBuilder<YouAndFoodBloc, YouAndFoodState>(
          builder: (BuildContext context, state) {
            final selectedAllergic = state.selectedAllergic;

            return Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: state.foodAllergens
                  .map(
                    (e) => SizedBox(
                      width: width,
                      child: _getCustomChoiceChip(
                        label: e.name,
                        selected: selectedAllergic.contains(e),
                        value: e,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }

  void _onSelected(FoodPreference value) {
    context.read<YouAndFoodBloc>().add(YouAndFoodEvent.setAllergic(value));
  }
}
