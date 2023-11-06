import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list_item.dart';

final List<MoodPickerListItem> moodPickerList = [
  MoodPickerListItem(icon: AppIcons.moodEmotionAngry, value: 1),
  MoodPickerListItem(icon: AppIcons.moodEmotionSad, value: 2),
  MoodPickerListItem(icon: AppIcons.moodEmotionNeutral, value: 3),
  MoodPickerListItem(icon: AppIcons.moodEmotionJoy, value: 4),
  MoodPickerListItem(icon: AppIcons.moodEmotionHappy, value: 5),
];
