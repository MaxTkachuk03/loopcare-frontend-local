import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class DoYouLikeChips extends StatefulWidget {
  const DoYouLikeChips({Key? key}) : super(key: key);

  @override
  State<DoYouLikeChips> createState() => _DoYouLikeChipsState();
}

class _DoYouLikeChipsState extends State<DoYouLikeChips> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final width = constraints.maxWidth / 2 - 5;
      return Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          SizedBox(
            width: width,
            child: AppChoiceChip(
              label: 'Beets',
              selected: false,
              value: 2,
              onSelected: (int value) {},
            ),
          ),
          SizedBox(
            width: width,
            child: AppChoiceChip(
              label: 'Olives',
              selected: false,
              value: 1,
              onSelected: (int value) {},
            ),
          ),
          SizedBox(
            width: width,
            child: AppChoiceChip(
              label: 'Cilantro',
              selected: false,
              value: 1,
              onSelected: (int value) {},
            ),
          ),
        ],
      );
    });
  }
}
