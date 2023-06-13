import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class ProgramQuestion extends StatelessWidget {
  final String question;

  const ProgramQuestion({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ).tr(),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            AppChoiceChip(
              label: 'e.name',
              selected: false,
              value: 1,
              onSelected: _onSelected,
            ),
            AppChoiceChip(
              label: 'e.name',
              selected: false,
              value: 1,
              onSelected: _onSelected,
            ),
            AppChoiceChip(
              label: 'e.name',
              selected: true,
              value: 1,
              onSelected: _onSelected,
            )
          ],
        )
      ],
    );
  }

  void _onSelected(int value) {
    print('_onSelected');
  }
}
