import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list_item.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_picker_regular_cell.dart';
import 'package:loopcare_frontend/features/mood/presentation/widgets/mood_picker_selected_cell.dart';

class MoodPicker extends StatelessWidget {
  final MoodPickerListItem? value;
  final void Function(MoodPickerListItem item)? onItemPressed;

  const MoodPicker({super.key, required this.onItemPressed, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: moodPickerList.mapIndexed(
          (i, el) {
            final bool isSelected = value == el;

            return Expanded(
              child: InkWell(
                onTap: () => onItemPressed?.call(el),
                child: isSelected
                    ? MoodPickerSelectedCell(child: el.icon)
                    : MoodPickerRegularCell(
                        isFirst: i == 0,
                        isLast: i == (moodPickerList.length - 1),
                        isOdd: i.isOdd,
                        child: el.icon,
                      ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
