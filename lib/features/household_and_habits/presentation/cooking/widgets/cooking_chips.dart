import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class CookingChips extends StatefulWidget {
  const CookingChips({super.key});

  @override
  State<CookingChips> createState() => _CookingChipsState();
}

class _CookingChipsState extends State<CookingChips> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          AppChoiceChip(
            label: 'Only me',
            selected: false,
            value: 1,
            onSelected: _onSelected,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0)
        ],
      ),
      Column(
        children: [
          AppChoiceChip(
            label: 'Someone else',
            selected: false,
            value: 2,
            onSelected: _onSelected,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0)
        ],
      ),
      Column(
        children: [
          AppChoiceChip(
            label: 'Me and others',
            selected: false,
            value: 3,
            onSelected: _onSelected,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0)
        ],
      ),
      Column(
        children: [
          AppChoiceChip(
            label: 'Nobody',
            selected: false,
            value: 4,
            onSelected: _onSelected,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0)
        ],
      ),
    ]);
  }

  void _onSelected(int value) {}
}
