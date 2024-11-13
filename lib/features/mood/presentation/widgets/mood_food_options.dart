import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_food.dart';

class MoodFoodOptions extends StatelessWidget {
  final void Function(MoodFood value) onChange;
  final List<MoodFood> selectedValues;

  const MoodFoodOptions({super.key, required this.onChange, required this.selectedValues});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final width = constraints.maxWidth / 2 - 5;

      return Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: MoodFood.values
            .map(
              (e) => SizedBox(
                width: width,
                child: CustomChoiceChip.orange(
                  label: e.value,
                  selected: selectedValues.contains(e),
                  value: e,
                  onSelected: onChange,
                ),
              ),
            )
            .toList(),
      );
    });
  }
}
