import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/household_and_habits/domain/eat_place_item.dart';

class WhereDoYouEatItem extends StatelessWidget {
  final String label;
  final List<EatPlaceItem> list;

  const WhereDoYouEatItem({
    Key? key,
    required this.label,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 86,
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              width: 26.0,
            ),
            Expanded(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final width = constraints.maxWidth / 2 - 5;

                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: list
                      .map(
                        (e) => SizedBox(
                          width: width,
                          child: AppChoiceChip(
                            label: e.name,
                            selected: false,
                            value: e.id,
                            onSelected: _onSelected,
                            padding: const EdgeInsets.all(0.0),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            )),
          ],
        ),
        const SizedBox(
          height: 24.0,
        )
      ],
    );
  }

  void _onSelected(int value) {}
}
