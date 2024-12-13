import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/account/application/food_preference/food_preference_bloc.dart';
import 'package:loopcare_frontend/features/account/infrastructure/food_preference/dto/food_preference.dart';

class TypesOfFoodChips extends StatefulWidget {
  final bool fromLessonComplete;

  const TypesOfFoodChips({
    super.key,
    required this.fromLessonComplete,
  });

  @override
  State<TypesOfFoodChips> createState() => _TypesOfFoodChipsState();
}

class _TypesOfFoodChipsState extends State<TypesOfFoodChips> {
  @override
  void initState() {
    context.read<FoodPreferenceBloc>().add(const FoodPreferenceEvent.fetchFoodPrefsTypes());
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
        return BlocBuilder<FoodPreferenceBloc, FoodPreferenceState>(
          builder: (BuildContext context, state) {
            final selectedHates = state.data.selectedHates;

            return Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: state.data.foodTypes
                  .map(
                    (e) => SizedBox(
                      width: width,
                      child: _getCustomChoiceChip(
                        label: e.name,
                        selected: selectedHates.contains(e),
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
    context.read<FoodPreferenceBloc>().add(FoodPreferenceEvent.setHates(value));
  }
}
