import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_picker_list_item.dart';

class MoodUtils {
  MoodUtils._();

  static getMoodIconByValue(int value) {
    switch (value) {
      case 5:
        return AppIcons.moodEmotionHappy;
      case 4:
        return AppIcons.moodEmotionJoy;
      case 3:
        return AppIcons.moodEmotionNeutral;
      case 2:
        return AppIcons.moodEmotionSad;
      case 1:
        return AppIcons.moodEmotionAngry;
    }
  }

  static getMoodByValue(int value) {
    switch (value) {
      case 5:
        return MoodPickerListItem(icon: AppIcons.moodEmotionHappy, value: 5);
      case 4:
        return MoodPickerListItem(icon: AppIcons.moodEmotionJoy, value: 4);
      case 3:
        return MoodPickerListItem(icon: AppIcons.moodEmotionNeutral, value: 3);
      case 2:
        return MoodPickerListItem(icon: AppIcons.moodEmotionSad, value: 2);
      case 1:
        return MoodPickerListItem(icon: AppIcons.moodEmotionAngry, value: 1);
    }
  }
}
