import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/biological_gender_type.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/reg_exp_utils.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class BiologicalGenderChips extends StatefulWidget {
  const BiologicalGenderChips({Key? key}) : super(key: key);

  @override
  State<BiologicalGenderChips> createState() => _BiologicalGenderChipsState();
}

class _BiologicalGenderChipsState extends State<BiologicalGenderChips> {
  BiologicalGenderType? _selectedValue;

  void _onSelectedBiologicalGenderHandler(BiologicalGenderType gender) {
    setState(() {
      _selectedValue = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: BiologicalGenderType.values
          .map(
            (BiologicalGenderType gender) => Column(
              children: [
                AppChoiceChip(
                  label: _getLabelText(gender.name),
                  selected: gender == _selectedValue,
                  value: gender,
                  onSelected: _onSelectedBiologicalGenderHandler,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }

  String _getLabelText(String str) {
    return str
        .split(RegExp(RegExpUtils.upperCaseLetters))
        .join(' ')
        .capitalize();
  }
}
