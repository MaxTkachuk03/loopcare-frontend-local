import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_with_who.dart';

class MoodWithWhoOption extends StatelessWidget {
  final void Function(MoodWithWho value) onChange;
  final List<MoodWithWho> selectedValues;

  const MoodWithWhoOption({super.key, required this.onChange, required this.selectedValues});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final width = constraints.maxWidth / 2 - 5;

      return Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: MoodWithWho.values
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
