import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';

class SexChips extends StatefulWidget {
  const SexChips({
    super.key,
    required this.initValue,
    required this.onChanged,
  });

  final SexType? initValue;
  final void Function(SexType gender) onChanged;

  @override
  State<SexChips> createState() => _SexChipsState();
}

class _SexChipsState extends State<SexChips> {
  SexType? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initValue;
  }


  void _onSelectedSexHandler(SexType value) {
    setState(() {
      _selectedValue = value;
    });

   widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: SexType.values.map(
          (item) => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomChoiceChip.yellow(
              label: item.title.tr(),
              selected: item == _selectedValue,
              onSelected: _onSelectedSexHandler,
              value: item,
              textAlign: TextAlign.center,
            ),
          ),
        ).toList(),
    );
  }
}
