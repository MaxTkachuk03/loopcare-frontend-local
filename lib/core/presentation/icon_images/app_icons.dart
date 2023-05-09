import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AppIcons {
  static const String iconsFilePath = 'assets/icons';

  static const AssetImage iconOpenEye = AssetImage(
    '$iconsFilePath/icon_open_eye.png',
  );
  static const AssetImage iconMail = AssetImage(
    '$iconsFilePath/mail.png',
  );
  static const AssetImage iconLock = AssetImage(
    '$iconsFilePath/lock.png',
  );
  static const AssetImage exclamationMark = AssetImage(
    '$iconsFilePath/exclamation_mark.png',
  );

  static const AssetImage arrow = AssetImage(
    '$iconsFilePath/arrow.png',
  );
  static const AssetImage checkmark = AssetImage(
    '$iconsFilePath/checkmark.png',
  );
  static const AssetImage list = AssetImage(
    '$iconsFilePath/list.png',
  );
  static const AssetImage scan = AssetImage(
    '$iconsFilePath/scan.png',
  );
  static const AssetImage plus = AssetImage(
    '$iconsFilePath/plus.png',
  );
  static const AssetImage dish = AssetImage(
    '$iconsFilePath/dish.png',
  );
  static const AssetImage chef = AssetImage(
    '$iconsFilePath/chef.png',
  );
  static const AssetImage edit = AssetImage(
    '$iconsFilePath/edit.png',
  );

  // Dashboard
  static const AssetImage dashboardWeight =
      AssetImage('$iconsFilePath/dashboard_weight.png');

  static const AssetImage dashbordLogMeals =
      AssetImage('$iconsFilePath/dashboard_log_meals.png');

  static const AssetImage dashbordPlanMeals =
      AssetImage('$iconsFilePath/dashboard_plan_meals.png');

  static const AssetImage dashbordExplore =
      AssetImage('$iconsFilePath/dashboard_explore.png');

  static const AssetImage dashbordReflection =
      AssetImage('$iconsFilePath/dashboard_reflection.png');

  static const AssetImage dashbordReflectionDone =
      AssetImage('$iconsFilePath/dashboard_reflection_done.png');

  static const AssetImage diaryEmotionGreat =
      AssetImage('$iconsFilePath/diary_emotion_great.png');

  static const AssetImage diaryEmotionHappy =
      AssetImage('$iconsFilePath/diary_emotion_happy.png');

  static const AssetImage diaryEmotionNeutral =
      AssetImage('$iconsFilePath/diary_emotion_neutral.png');

  static const AssetImage diaryEmotionSad =
      AssetImage('$iconsFilePath/diary_emotion_sad.png');

  static const AssetImage diaryEmotionUnhappy =
      AssetImage('$iconsFilePath/diary_emotion_unhappy.png');

  static const AssetImage physicalExercise =
      AssetImage('$iconsFilePath/physical_exercise.png');

  static const AssetImage supportGroup =
      AssetImage('$iconsFilePath/support_group.png');

  static const AssetImage overview = AssetImage('$iconsFilePath/overview.png');

  static const AssetImage explore = AssetImage('$iconsFilePath/explore.png');

  static const AssetImage drinks = AssetImage('$iconsFilePath/icon_drinks.png');

  static const AssetImage iconCheckmark =
      AssetImage('$iconsFilePath/icon_checkmark.png');

  static const AssetImage porkKnife =
      AssetImage('$iconsFilePath/icon_pork_knife.png');

  static const AssetImage snack = AssetImage('$iconsFilePath/icon_snack.png');

  static SvgPicture person = SvgPicture.asset('$iconsFilePath/person.svg');

  static SvgPicture clock = SvgPicture.asset('$iconsFilePath/clock.svg');

  static SvgPicture clockGrey = SvgPicture.asset(
    '$iconsFilePath/clock.svg',
    color: AppColors.greyLabel,
    width: 21,
    height: 21,
  );

  static SvgPicture calendar = SvgPicture.asset('$iconsFilePath/calendar.svg');

  static SvgPicture calendarFull =
      SvgPicture.asset('$iconsFilePath/calendar_full.svg');

  static SvgPicture book = SvgPicture.asset('$iconsFilePath/book.svg');

  static SvgPicture bookFull = SvgPicture.asset('$iconsFilePath/book_full.svg');

  static SvgPicture account = SvgPicture.asset('$iconsFilePath/account.svg');

  static SvgPicture accountFull =
      SvgPicture.asset('$iconsFilePath/account_full.svg');

  AppIcons._();
}
