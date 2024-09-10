import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/diabetes_types.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';

class DiabetesChips extends StatefulWidget {
  const DiabetesChips({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final DiabetesTypes? initialValue;
  final void Function(DiabetesTypes value) onChanged;

  @override
  State<DiabetesChips> createState() => _DiabetesChipsState();
}

class _DiabetesChipsState extends State<DiabetesChips> {
  DiabetesTypes? _selectedValue;

  @override
  void initState() {
    super.initState();
    final state = context.read<MedicalQuestionsBloc>().state;

    if (state.containsDiabetesTypeI) {
      _selectedValue = DiabetesTypes.typeOne;
    } else if (state.containsDiabetesTypeII) {
      _selectedValue = DiabetesTypes.typeTwo;
    } else if (state.containsDiabetesAnswer) {
      _selectedValue = DiabetesTypes.no;
    }
  }

  void _onSelected(DiabetesTypes value) {
    setState(() {
      _selectedValue = value;
    });

    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: DiabetesTypes.values
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomChoiceChip.coral(
                  label: item.label,
                  selected: item == _selectedValue,
                  onSelected: _onSelected,
                  value: item,
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
    );
  }
}
