import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list_item.dart';

class MoodPicker extends StatelessWidget {
  final MoodPickerListItem? value;
  final void Function(MoodPickerListItem item) onItemPressed;

  const MoodPicker({super.key, required this.onItemPressed, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.FF404040),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      height: 65,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: moodPickerList.length,
          itemBuilder: (BuildContext context, int i) {
            final item = moodPickerList[i];

            final bool isSelected = value == item;

            return InkWell(
              onTap: () => onItemPressed(item),
              child: Container(
                decoration: BoxDecoration(
                  border: i.isOdd
                      ? const Border.symmetric(vertical: BorderSide(width: 1, color: AppColors.FF404040))
                      : null,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: Opacity(
                  opacity: isSelected ? 1 : 0.3,
                  child: item.icon,
                ),
              ),
            );
          }),
    );
  }
}
