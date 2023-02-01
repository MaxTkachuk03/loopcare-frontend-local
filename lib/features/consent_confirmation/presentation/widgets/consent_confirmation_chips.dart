import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/consent_confirmation/domain/consent_confirmation_answers.dart';

class ConsentConfirmationChips extends StatefulWidget {
  const ConsentConfirmationChips({Key? key}) : super(key: key);

  @override
  State<ConsentConfirmationChips> createState() =>
      _ConsentConfirmationChipsState();
}

class _ConsentConfirmationChipsState extends State<ConsentConfirmationChips> {
  ConsentConfirmationAnswers? _selectedValue;

  void _onSelected(ConsentConfirmationAnswers value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ConsentConfirmationAnswers.values
          .map(
            (ConsentConfirmationAnswers value) => Column(
              children: [
                AppChoiceChip(
                  label: value.label,
                  selected: value == _selectedValue,
                  value: value,
                  onSelected: _onSelected,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }
}
