import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';

class QuestionsChips extends StatefulWidget {
  const QuestionsChips({
    super.key,
    required this.initialValue,
    required this.onSelected,
  });

  final void Function(bool value) onSelected;
  final bool? initialValue;


  @override
  State<QuestionsChips> createState() => _QuestionsChipsState();
}

class _QuestionsChipsState extends State<QuestionsChips> {
  YesNoAnswer? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = fromBoolOrNull(widget.initialValue);
  }

  void _onSelected(YesNoAnswer answer) {
    setState(() {
      _selectedValue = answer;
    });

    widget.onSelected(answer.value);
  }

  YesNoAnswer? fromBoolOrNull(bool? value) {
    if (value == null) {
      return null;
    } else if (value) {
      return YesNoAnswer.yes;
    } else {
      return YesNoAnswer.no;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: YesNoAnswer.values
          .map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomChoiceChip.coral(
              label: item.label,
              selected: item == _selectedValue,
              onSelected: _onSelected,
              value: item,
            ),
          ))
          .toList(),
    );
  }
}
