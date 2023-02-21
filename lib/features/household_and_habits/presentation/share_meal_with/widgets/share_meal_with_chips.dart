import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class ShareMealWithChips extends StatefulWidget {
  const ShareMealWithChips({Key? key}) : super(key: key);

  @override
  State<ShareMealWithChips> createState() => _ShareMealWithChipsState();
}

class _ShareMealWithChipsState extends State<ShareMealWithChips> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            AppChoiceChip(
              label: 'Just me',
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
              label: '2 people',
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
              label: '3 people',
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
              label: '4 people',
              selected: false,
              value: 4,
              onSelected: _onSelected,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0)
          ],
        ),
      ]
    );
  }

  void _onSelected(int value) {
  }
}
