import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppIcons {
  static const String iconsFilePath = 'assets/icons';
  static const String upArrow = 'assets/images/up_arrow.png';

  // TODO replace with material svg icons
  static const AssetImage arrow = AssetImage('$iconsFilePath/arrow.png');
  static const AssetImage downArrow =
      AssetImage('$iconsFilePath/down_arrow.png');
  static const AssetImage iconCheckmark =
      AssetImage('$iconsFilePath/icon_checkmark.png');
  static const AssetImage checkmark = AssetImage(
      '$iconsFilePath/checkmark.png'); // same with iconCheckmark with another color
  static SvgPicture checkmarkSVG =
      SvgPicture.asset('$iconsFilePath/check_mark.svg', width: 24, height: 24);
  static SvgPicture greenCheckmark =
      SvgPicture.asset('$iconsFilePath/green_checkmark.svg');
  static const AssetImage delete = AssetImage('$iconsFilePath/delete.png');
  static const AssetImage edit = AssetImage('$iconsFilePath/edit.png');
  static const AssetImage detailsLayout =
      AssetImage('$iconsFilePath/icon_detail.png');
  static const AssetImage listLayout =
      AssetImage('$iconsFilePath/icon_list.png');
  static const AssetImage magnifyingGlass =
      AssetImage('$iconsFilePath/icon_magnifying_glass.png');
  static const AssetImage starFilled =
      AssetImage('$iconsFilePath/icon_star_filled.png');
  static const AssetImage list = AssetImage('$iconsFilePath/list.png');
  static const AssetImage plus = AssetImage('$iconsFilePath/plus.png');
  static const AssetImage scan = AssetImage('$iconsFilePath/scan.png');
  static const AssetImage doneDayButton =
      AssetImage('$iconsFilePath/done_day.png');
  static const AssetImage commitmentButton =
      AssetImage('$iconsFilePath/commitment.png');
  static SvgPicture clock = SvgPicture.asset(
    '$iconsFilePath/clock.svg',
    width: 24,
    height: 24,
  );
  static SvgPicture clockWhite = SvgPicture.asset('$iconsFilePath/clock.svg',
      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn));
  static SvgPicture clockGrey =
      SvgPicture.asset('$iconsFilePath/clock.svg', width: 21, height: 21);
  static SvgPicture lockGoals =
      SvgPicture.asset('$iconsFilePath/lock_goals.svg');

  static SvgPicture checkmarkCircle(
          bool selected, Color selectedColor, Color regularColor) =>
      SvgPicture.asset('$iconsFilePath/checkmark_circle.svg',
          width: 22,
          height: 22,
          colorFilter: ColorFilter.mode(
              selected ? selectedColor : regularColor, BlendMode.srcIn));
  static SvgPicture dashboardChat = SvgPicture.asset(
    '$iconsFilePath/dashboard_chat.svg',
    colorFilter:
        ColorFilter.mode(AppColors.white.withOpacity(0.5), BlendMode.srcIn),
  );
  static SvgPicture dashboardChatActive =
      SvgPicture.asset('$iconsFilePath/dashboard_chat.svg');

  static SvgPicture navigationBarPractice =
      SvgPicture.asset('$iconsFilePath/bar_practice.svg');
  static SvgPicture navigationBarRiver =
      SvgPicture.asset('$iconsFilePath/bar_river.svg');

  static SvgPicture infoQuestion =
      SvgPicture.asset('$iconsFilePath/icon_info_question.svg');
  static SvgPicture orangeExclamationMark =
      SvgPicture.asset('$iconsFilePath/orange_exclamation_mark.svg');
  static SvgPicture settings = SvgPicture.asset('$iconsFilePath/settings.svg');

  // TODO replace with svg version
  // <--
  static const AssetImage cutlery = AssetImage('$iconsFilePath/cutlery.png');
  static const AssetImage exclamationMark =
      AssetImage('$iconsFilePath/exclamation_mark.png');
  static const AssetImage exclamationPoint =
      AssetImage('$iconsFilePath/exclamation_point.png');
  static const AssetImage cook = AssetImage('$iconsFilePath/icon_cook.png');
  static const AssetImage pan = AssetImage('$iconsFilePath/icon_pan.png');

  // -->

  static SvgPicture moodEmotionHappy =
      SvgPicture.asset('$iconsFilePath/mood_emotion_happy.svg');

  static SvgPicture moodEmotionJoy =
      SvgPicture.asset('$iconsFilePath/mood_emotion_joy.svg');

  static SvgPicture moodEmotionNeutral =
      SvgPicture.asset('$iconsFilePath/mood_emotion_neutral.svg');

  static SvgPicture moodEmotionAngry =
      SvgPicture.asset('$iconsFilePath/mood_emotion_angry.svg');

  static SvgPicture moodEmotionSad =
      SvgPicture.asset('$iconsFilePath/mood_emotion_sad.svg');

  static SvgPicture emojiSad =
      SvgPicture.asset('$iconsFilePath/sad.svg', width: 30, height: 30);

  static SvgPicture emojiWorried =
      SvgPicture.asset('$iconsFilePath/worried.svg', width: 30, height: 30);

  static SvgPicture emojiEmbarrassed =
      SvgPicture.asset('$iconsFilePath/embarrassed.svg', width: 30, height: 30);

  static SvgPicture emojiBored =
      SvgPicture.asset('$iconsFilePath/bored.svg', width: 30, height: 30);

  static SvgPicture emojiProud =
      SvgPicture.asset('$iconsFilePath/proud.svg', width: 30, height: 30);

  static SvgPicture emojiHappy =
      SvgPicture.asset('$iconsFilePath/happy.svg', width: 30, height: 30);

  static SvgPicture emojiEnergized =
      SvgPicture.asset('$iconsFilePath/energized.svg', width: 30, height: 30);

  static SvgPicture emojiSick =
      SvgPicture.asset('$iconsFilePath/sick.svg', width: 30, height: 30);

  static SvgPicture emojiAngry =
      SvgPicture.asset('$iconsFilePath/angry.svg', width: 30, height: 30);

  static SvgPicture emojiAshamed =
      SvgPicture.asset('$iconsFilePath/ashamed.svg', width: 30, height: 30);

  static SvgPicture emojiNervous =
      SvgPicture.asset('$iconsFilePath/nervous.svg', width: 30, height: 30);

  static SvgPicture emojiExhausted =
      SvgPicture.asset('$iconsFilePath/exhausted.svg', width: 30, height: 30);

  static SvgPicture emojiContent =
      SvgPicture.asset('$iconsFilePath/content.svg', width: 30, height: 30);

  static SvgPicture emojiOverwhelmed =
      SvgPicture.asset('$iconsFilePath/overwhelmed.svg', width: 30, height: 30);

  static SvgPicture emojiHungry =
      SvgPicture.asset('$iconsFilePath/hungry.svg', width: 30, height: 30);

  static SvgPicture emojiLonely =
      SvgPicture.asset('$iconsFilePath/lonely.svg', width: 30, height: 30);

  static SvgPicture calendarWarning = SvgPicture.asset(
      '$iconsFilePath/calendar.svg',
      colorFilter:
          const ColorFilter.mode(AppColors.darkGreen, BlendMode.srcIn));

  static SvgPicture telephone =
      SvgPicture.asset('$iconsFilePath/telephone.svg');

  static SvgPicture sos = SvgPicture.asset('$iconsFilePath/sos.svg');

  static SvgPicture sessionUserDefaultAvatar =
      SvgPicture.asset('$iconsFilePath/session_user_default_avatar.svg');

  static SvgPicture copy =
      SvgPicture.asset('$iconsFilePath/new_copy.svg', width: 24, height: 24);

  static SvgPicture reply =
      SvgPicture.asset('$iconsFilePath/new_reply.svg', width: 24, height: 24);

  static SvgPicture report =
      SvgPicture.asset('$iconsFilePath/new_report.svg', width: 17, height: 17);

  static SvgPicture remove =
      SvgPicture.asset('$iconsFilePath/new_remove.svg', width: 17, height: 17);

  static SvgPicture send = SvgPicture.asset(
    '$iconsFilePath/send.svg',
    width: 24.0,
    height: 24.0,
  );

  static SvgPicture holderAvatar = SvgPicture.asset(
      '$iconsFilePath/holder_avatar.svg',
      width: 30.0,
      height: 30.0);

  static SvgPicture fruit =
      SvgPicture.asset('$iconsFilePath/fruit.svg', width: 24, height: 24);
  static SvgPicture restaurant =
      SvgPicture.asset('$iconsFilePath/restaurant.svg', width: 24, height: 24);

  static SvgPicture drinkSVG =
      SvgPicture.asset('$iconsFilePath/drink.svg', width: 24, height: 24);

  static SvgPicture customDashboardReflections = SvgPicture.asset(
      '$iconsFilePath/custom_dashboard_reflections.svg',
      width: 44,
      height: 44);
  static SvgPicture commitment =
      SvgPicture.asset('$iconsFilePath/commitment.svg', width: 44, height: 44);
  static SvgPicture customSupportGroup = SvgPicture.asset(
      '$iconsFilePath/custom_support_group.svg',
      width: 44,
      height: 44);
  static SvgPicture customSupportGroupGrey = SvgPicture.asset(
      '$iconsFilePath/support_group.svg',
      width: 44,
      height: 44);
  static SvgPicture customPhysicalExercise = SvgPicture.asset(
      '$iconsFilePath/custom_physical_exercise.svg',
      width: 44,
      height: 44);
  static SvgPicture customPhysicalExerciseGrey = SvgPicture.asset(
      '$iconsFilePath/physical_activity.svg',
      width: 44,
      height: 44);
  static SvgPicture customDashboardLogMeals = SvgPicture.asset(
      '$iconsFilePath/custom_dashboard_log_meals.svg',
      width: 44,
      height: 44);
  static SvgPicture customDashboardLogMealsGrey = SvgPicture.asset(
      '$iconsFilePath/log_meals_goals.svg',
      width: 44,
      height: 44);
  static SvgPicture customDashboardWeight = SvgPicture.asset(
      '$iconsFilePath/custom_dashboard_weight.svg',
      width: 44,
      height: 44);
  static SvgPicture customDashboardWeightGrey = SvgPicture.asset(
      '$iconsFilePath/weight_locked.svg',
      width: 44,
      height: 44);
  static SvgPicture customEducationDashboard = SvgPicture.asset(
      '$iconsFilePath/custom_education_dashboard.svg',
      width: 44,
      height: 44);
  static SvgPicture customDashboardMood = SvgPicture.asset(
      '$iconsFilePath/custom_dashboard_mood.svg',
      width: 44,
      height: 44);
  static SvgPicture customDashboardMoodGrey =
      SvgPicture.asset('$iconsFilePath/mood_locked.svg', width: 44, height: 44);
  static SvgPicture customDashboardMind =
      SvgPicture.asset('$iconsFilePath/mind.svg', width: 44, height: 44);
  static SvgPicture customDashboardMindGrey = SvgPicture.asset(
      '$iconsFilePath/mind_training.svg',
      width: 44,
      height: 44);
  static SvgPicture customDashboardSmartGoals = SvgPicture.asset(
      '$iconsFilePath/custom_dashboard_smart_goals.svg',
      width: 44,
      height: 44);
  static SvgPicture customDashboardSmartGoalsGrey =
      SvgPicture.asset('$iconsFilePath/my_goals.svg', width: 44, height: 44);
  static SvgPicture customRedPhone =
      SvgPicture.asset('$iconsFilePath/custom_red_phone.svg');
  static SvgPicture microphoneOn =
      SvgPicture.asset('$iconsFilePath/icon_microphone_on.svg');
  static SvgPicture microphoneOff =
      SvgPicture.asset('$iconsFilePath/icon_microphone_off.svg');
  static SvgPicture cameraOn =
      SvgPicture.asset('$iconsFilePath/icon_camera_on.svg');
  static SvgPicture cameraOff =
      SvgPicture.asset('$iconsFilePath/icon_camera_off.svg');

  static SvgPicture mealEmpty =
      SvgPicture.asset('$iconsFilePath/meal_empty.svg', width: 44, height: 44);

  static SvgPicture lock = SvgPicture.asset('$iconsFilePath/new_lock.svg');

  static SvgPicture customPan = SvgPicture.asset(
    '$iconsFilePath/icon_pan.svg',
    width: 16,
    height: 16,
    colorFilter:
        const ColorFilter.mode(AppColors.petrolRegular, BlendMode.srcIn),
  );
  static SvgPicture customStar = SvgPicture.asset(
    '$iconsFilePath/icon_star_filled.svg',
    width: 24,
    height: 24,
    colorFilter:
        const ColorFilter.mode(AppColors.petrolRegular, BlendMode.srcIn),
  );
  static SvgPicture customCutlery = SvgPicture.asset(
    '$iconsFilePath/icon_cutlery.svg',
    width: 16,
    height: 16,
    colorFilter:
        const ColorFilter.mode(AppColors.petrolRegular, BlendMode.srcIn),
  );

  static SvgPicture yesScore =
      SvgPicture.asset('$iconsFilePath/yes_score.svg', width: 22, height: 22);
  static SvgPicture noScore =
      SvgPicture.asset('$iconsFilePath/no_score.svg', width: 22, height: 22);
  static SvgPicture yesScoreFilled = SvgPicture.asset(
      '$iconsFilePath/yes_score_filled.svg',
      width: 22,
      height: 22);
  static SvgPicture customInfo = SvgPicture.asset(
      '$iconsFilePath/custom_icon_info.svg',
      width: 44,
      height: 44);

  static SvgPicture locked = SvgPicture.asset('$iconsFilePath/lock.svg');
  static SvgPicture achieve =
      SvgPicture.asset('$iconsFilePath/achieve.svg', width: 22, height: 22);

  static SvgPicture lightbulbSelect = SvgPicture.asset(
      '$iconsFilePath/lightbulb_select.svg',
      width: 22,
      height: 22);
  static SvgPicture lightbulbUnSelect = SvgPicture.asset(
      '$iconsFilePath/lightbulb_unselect.svg',
      width: 22,
      height: 22);
  static SvgPicture iReflectionDisable =
      SvgPicture.asset('$iconsFilePath/icon_reflection_disable.svg');
  static SvgPicture iReflectionUnlock =
      SvgPicture.asset('$iconsFilePath/icon_reflection_unlock.svg');
  static SvgPicture iReflectionCompleted =
      SvgPicture.asset('$iconsFilePath/icon_reflection_completed.svg');

  static SvgPicture userAvatarIconBlue =
      SvgPicture.asset('$iconsFilePath/user_avatar_icon_blue.svg');
  static SvgPicture userAvatarIconCoral =
      SvgPicture.asset('$iconsFilePath/user_avatar_icon_coral.svg');
  static SvgPicture userAvatarIconGreen =
      SvgPicture.asset('$iconsFilePath/user_avatar_icon_green.svg');
  static SvgPicture userAvatarIconOrange =
      SvgPicture.asset('$iconsFilePath/user_avatar_icon_orange.svg');
  static SvgPicture userAvatarIconPetrol =
      SvgPicture.asset('$iconsFilePath/user_avatar_icon_petrol.svg');
  static SvgPicture userAvatarIconYellow =
      SvgPicture.asset('$iconsFilePath/user_avatar_icon_yellow.svg');
  static SvgPicture userAvatarIconPhoto =
      SvgPicture.asset('$iconsFilePath/user_avatar_icon_photo.svg');

  static SvgPicture femaleAvatarTone1 =
      SvgPicture.asset('$iconsFilePath/female_avatar_tone1.svg');
  static SvgPicture femaleAvatarTone2 =
      SvgPicture.asset('$iconsFilePath/female_avatar_tone2.svg');
  static SvgPicture femaleAvatarTone3 =
      SvgPicture.asset('$iconsFilePath/female_avatar_tone3.svg');
  static SvgPicture femaleAvatarTone4 =
      SvgPicture.asset('$iconsFilePath/female_avatar_tone4.svg');

  static SvgPicture maleAvatarTone1 =
      SvgPicture.asset('$iconsFilePath/male_avatar_tone1.svg');
  static SvgPicture maleAvatarTone2 =
      SvgPicture.asset('$iconsFilePath/male_avatar_tone2.svg');
  static SvgPicture maleAvatarTone3 =
      SvgPicture.asset('$iconsFilePath/male_avatar_tone3.svg');
  static SvgPicture maleAvatarTone4 =
      SvgPicture.asset('$iconsFilePath/male_avatar_tone4.svg');

  static SvgPicture dashedBorder =
      SvgPicture.asset('$iconsFilePath/dashed_border.svg');

  static SvgPicture nutritionSubtract = SvgPicture.asset(
    '$iconsFilePath/subtract.svg',
    width: 20.0,
    height: 20.0,
  );

  static const String avatarIconPhotoPath =
      '$iconsFilePath/user_avatar_icon_photo.svg';
  static const String avatarIconBluePath =
      '$iconsFilePath/user_avatar_icon_blue.svg';

  static SvgPicture confetti = SvgPicture.asset('$iconsFilePath/confetti.svg');

  static SvgPicture interactiveLessonCheckmark(
          bool clicked, Color clickedColor, Color regularColor) =>
      SvgPicture.asset('$iconsFilePath/checkmark_circle.svg',
          width: 44,
          height: 44,
          colorFilter: ColorFilter.mode(
              clicked ? clickedColor : regularColor, BlendMode.srcIn));

  static SvgPicture interactiveLessonAddTextField(
          bool clicked, Color clickedColor, Color regularColor) =>
      SvgPicture.asset('$iconsFilePath/add_textfield.svg',
          width: 44,
          height: 44,
          colorFilter: ColorFilter.mode(
              clicked ? clickedColor : regularColor, BlendMode.modulate));

  static SvgPicture interactiveLessonEditPencil(
          bool clicked, Color clickedColor, Color regularColor) =>
      SvgPicture.asset('$iconsFilePath/edit_pencil.svg',
          width: 44,
          height: 44,
          colorFilter: ColorFilter.mode(
              clicked ? clickedColor : regularColor, BlendMode.srcIn));

  static SvgPicture interactiveLessonBucket(
          bool clicked, Color clickedColor, Color regularColor) =>
      SvgPicture.asset('$iconsFilePath/bucket.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
              clicked ? clickedColor : regularColor, BlendMode.srcIn));

  AppIcons._();
}
