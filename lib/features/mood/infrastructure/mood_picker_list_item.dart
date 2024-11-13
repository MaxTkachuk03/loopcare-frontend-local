import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_picker_list_item.freezed.dart';

@freezed
class MoodPickerListItem with _$MoodPickerListItem {
  const MoodPickerListItem._();

  const factory MoodPickerListItem({
    required SvgPicture icon,
    required int value,
  }) = _MoodPickerListItem;
}
