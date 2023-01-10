import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/medical/domain/pregnancy_type.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class PregnancyChips extends StatefulWidget {
  const PregnancyChips({Key? key}) : super(key: key);

  @override
  State<PregnancyChips> createState() => _PregnancyChipsState();
}

class _PregnancyChipsState extends State<PregnancyChips> {
  PregnancyType? _selectedValue;

  void _onSelectedPregnancyHandler(PregnancyType value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PregnancyType.values
          .map(
            (PregnancyType value) => Column(
              children: [
                AppChoiceChip(
                  label: _getLabelText(value),
                  selected: value == _selectedValue,
                  value: value,
                  onSelected: _onSelectedPregnancyHandler,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }

  String _getLabelText(PregnancyType value) {
    switch (value) {
      case PregnancyType.yes:
        {
          return LocalizedTexts.yes.tr().capitalize();
        }
      case PregnancyType.no:
        {
          return LocalizedTexts.no.tr().capitalize();
        }
    }
  }
}
