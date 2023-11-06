import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppIcons {
  static const String iconsFilePath = 'assets/icons';

  static const AssetImage iconOpenEye = AssetImage('$iconsFilePath/icon_open_eye.png');

  static const AssetImage iconMail = AssetImage('$iconsFilePath/mail.png');

  static const AssetImage iconLock = AssetImage('$iconsFilePath/lock.png');

  static const AssetImage exclamationMark = AssetImage('$iconsFilePath/exclamation_mark.png');

  static const AssetImage recommendations = AssetImage('$iconsFilePath/recommendations.png');

  static const AssetImage arrow = AssetImage('$iconsFilePath/arrow.png');

  static const AssetImage checkmark = AssetImage('$iconsFilePath/checkmark.png');

  static const AssetImage list = AssetImage('$iconsFilePath/list.png');

  static const AssetImage scan = AssetImage('$iconsFilePath/scan.png');

  static const AssetImage plus = AssetImage('$iconsFilePath/plus.png');

  static const AssetImage dish = AssetImage('$iconsFilePath/dish.png');

  static const AssetImage chef = AssetImage('$iconsFilePath/chef.png');

  static const AssetImage edit = AssetImage('$iconsFilePath/edit.png');

  static const AssetImage arrowDown = AssetImage('$iconsFilePath/arrow_down.png');

  static const AssetImage starFilled = AssetImage('$iconsFilePath/icon_star_filled.png');

  static const AssetImage pan = AssetImage('$iconsFilePath/icon_pan.png');

  static const AssetImage magnifyingGlass = AssetImage('$iconsFilePath/icon_magnifying_glass.png');

  static const AssetImage cook = AssetImage('$iconsFilePath/icon_cook.png');

  static const AssetImage cutlery = AssetImage('$iconsFilePath/cutlery.png');

  static const AssetImage unlock = AssetImage('$iconsFilePath/unlock.png');

  // Dashboard
  static const AssetImage dashboardWeight = AssetImage('$iconsFilePath/dashboard_weight.png');

  static const AssetImage dashboardLogMeals = AssetImage('$iconsFilePath/dashboard_log_meals.png');

  static const AssetImage dashboardPlanMeals = AssetImage('$iconsFilePath/dashboard_plan_meals.png');

  static const AssetImage dashboardExplore = AssetImage('$iconsFilePath/dashboard_explore.png');

  static const AssetImage phone = AssetImage('$iconsFilePath/phone.png');

  static const AssetImage dashboardReflection = AssetImage('$iconsFilePath/dashboard_reflection.png');

  static const AssetImage dashboardReflectionDone =
      AssetImage('$iconsFilePath/dashboard_reflection_done.png');

  static const AssetImage physicalExercise = AssetImage('$iconsFilePath/physical_exercise.png');

  static const AssetImage supportGroup = AssetImage('$iconsFilePath/support_group.png');

  static const AssetImage overview = AssetImage('$iconsFilePath/overview.png');

  static const AssetImage explore = AssetImage('$iconsFilePath/explore.png');

  static const AssetImage drinks = AssetImage('$iconsFilePath/icon_drinks.png');

  static const AssetImage iconCheckmark = AssetImage('$iconsFilePath/icon_checkmark.png');

  static const AssetImage porkKnife = AssetImage('$iconsFilePath/icon_pork_knife.png');

  static const AssetImage snack = AssetImage('$iconsFilePath/icon_snack.png');

  static SvgPicture person = SvgPicture.asset('$iconsFilePath/person.svg');

  static SvgPicture cameraOff = SvgPicture.asset('$iconsFilePath/camera_off.svg');

  static SvgPicture microphone = SvgPicture.asset('$iconsFilePath/microphone.svg');

  static SvgPicture settings = SvgPicture.asset('$iconsFilePath/settings.svg');

  static SvgPicture introReflection = SvgPicture.asset('$iconsFilePath/intro_reflection.svg');

  static const AssetImage delete = AssetImage('$iconsFilePath/delete.png');

  static SvgPicture clock = SvgPicture.asset('$iconsFilePath/clock.svg');

  static SvgPicture clockWhite = SvgPicture.asset('$iconsFilePath/clock.svg',
      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn));

  static SvgPicture clockGrey = SvgPicture.asset('$iconsFilePath/clock.svg', width: 21, height: 21);

  static SvgPicture dashboardMood =
      SvgPicture.asset('$iconsFilePath/dashboard_mood.svg', width: 44, height: 42);

  static SvgPicture moodEmotionHappy = SvgPicture.asset('$iconsFilePath/mood_emotion_happy.svg');

  static SvgPicture moodEmotionJoy = SvgPicture.asset('$iconsFilePath/mood_emotion_joy.svg');

  static SvgPicture moodEmotionNeutral = SvgPicture.asset('$iconsFilePath/mood_emotion_neutral.svg');

  static SvgPicture moodEmotionAngry = SvgPicture.asset('$iconsFilePath/mood_emotion_angry.svg');

  static SvgPicture moodEmotionSad = SvgPicture.asset('$iconsFilePath/mood_emotion_sad.svg');

  static SvgPicture emojiSad = SvgPicture.asset('$iconsFilePath/sad.svg', width: 30, height: 30);

  static SvgPicture emojiWorried = SvgPicture.asset('$iconsFilePath/worried.svg', width: 30, height: 30);

  static SvgPicture emojiEmbarrassed =
      SvgPicture.asset('$iconsFilePath/embarrassed.svg', width: 30, height: 30);

  static SvgPicture emojiBored = SvgPicture.asset('$iconsFilePath/bored.svg', width: 30, height: 30);

  static SvgPicture emojiProud = SvgPicture.asset('$iconsFilePath/proud.svg', width: 30, height: 30);

  static SvgPicture emojiHappy = SvgPicture.asset('$iconsFilePath/happy.svg', width: 30, height: 30);

  static SvgPicture emojiEnergized = SvgPicture.asset('$iconsFilePath/energized.svg', width: 30, height: 30);

  static SvgPicture emojiSick = SvgPicture.asset('$iconsFilePath/sick.svg', width: 30, height: 30);

  static SvgPicture emojiAngry = SvgPicture.asset('$iconsFilePath/angry.svg', width: 30, height: 30);

  static SvgPicture emojiAshamed = SvgPicture.asset('$iconsFilePath/ashamed.svg', width: 30, height: 30);

  static SvgPicture emojiNervous = SvgPicture.asset('$iconsFilePath/nervous.svg', width: 30, height: 30);

  static SvgPicture emojiExhausted = SvgPicture.asset('$iconsFilePath/exhausted.svg', width: 30, height: 30);

  static SvgPicture emojiContent = SvgPicture.asset('$iconsFilePath/content.svg', width: 30, height: 30);

  static SvgPicture emojiOverwhelmed =
      SvgPicture.asset('$iconsFilePath/overwhelmed.svg', width: 30, height: 30);

  static SvgPicture emojiHungry = SvgPicture.asset('$iconsFilePath/hungry.svg', width: 30, height: 30);

  static SvgPicture emojiLonely = SvgPicture.asset('$iconsFilePath/lonely.svg', width: 30, height: 30);

  static SvgPicture calendar = SvgPicture.asset('$iconsFilePath/calendar.svg');

  static SvgPicture calendarFull = SvgPicture.asset('$iconsFilePath/calendar_full.svg');

  static SvgPicture book = SvgPicture.asset('$iconsFilePath/book.svg');

  static SvgPicture bookFull = SvgPicture.asset('$iconsFilePath/book_full.svg');

  static SvgPicture account = SvgPicture.asset('$iconsFilePath/account.svg');

  static SvgPicture accountFull = SvgPicture.asset('$iconsFilePath/account_full.svg');

  static SvgPicture telephone = SvgPicture.asset('$iconsFilePath/telephone.svg');

  static SvgPicture sos = SvgPicture.asset('$iconsFilePath/sos.svg');

  static const AssetImage listLayout = AssetImage('$iconsFilePath/icon_list.png');

  static const AssetImage detailsLayout = AssetImage('$iconsFilePath/icon_detail.png');

  static SvgPicture greenPhone = SvgPicture.asset('$iconsFilePath/green_phone.svg');

  static SvgPicture sessionUserDefaultAvatar =
      SvgPicture.asset('$iconsFilePath/session_user_default_avatar.svg');

  static const AssetImage exclamationPoint = AssetImage('$iconsFilePath/exclamation_point.png');

  static const AssetImage hexaDone = AssetImage('$iconsFilePath/hexa_done.png');

  AppIcons._();
}
