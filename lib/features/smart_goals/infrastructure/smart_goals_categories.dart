import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';

enum SmartGoalsCategory {
  sleep(1, 'Sleep'),
  mealTiming(2, 'Meal timing'),
  calorieDensity(3, 'Calorie density'),
  protein(4, 'Protein'),
  carbohydrates(5, 'Carbohydrates'),
  fats(6, 'Fats'),
  water(7, 'Water');

  const SmartGoalsCategory(this.number, this.value);

  static SmartGoalsCategory getValueByString(String val) => values.firstWhere((e) => e.value == val);

  final int number;
  final String value;

  Widget get icon {
    switch (value) {
      case 'Sleep':
        return AppIcons.emojiSleep;
      case 'Meal timing':
        return AppIcons.emojiAlarmClock;
      case 'Calorie density':
        return AppIcons.emojiCarrot;
      case 'Protein':
        return AppIcons.emojiFlexedBiceps;
      case 'Carbohydrates':
        return AppIcons.emojiPotato;
      case 'Fats':
        return AppIcons.emojiButter;
      case 'Water':
        return AppIcons.emojiSweatDroplets;
      default:
        return AppIcons.emojiSleep;
    }
  }
}
