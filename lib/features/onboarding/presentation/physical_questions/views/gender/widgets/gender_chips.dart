import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';

class GenderChips extends StatefulWidget {
  const GenderChips({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  final GenderType? initValue;
  final void Function(GenderType gender) onChanged;

  @override
  State<GenderChips> createState() => _GenderChipsState();
}

class _GenderChipsState extends State<GenderChips> {
  GenderType? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initValue;
  }

  void _onSelected(GenderType gender) {
    setState(() {
      _selectedGender = gender;
    });

    widget.onChanged(gender);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: GenderType.values.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomChoiceChip.yellow(
              label: item.title.tr(),
              selected: item == _selectedGender,
              onSelected: _onSelected,
              value: item,
              textAlign: TextAlign.center,
            ),
          ),
        ).toList(),
    );
  }
}
